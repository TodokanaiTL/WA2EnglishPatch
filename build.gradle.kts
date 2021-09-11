group = "io.github.todokanaitl"
version = "1.0.0"

plugins {
    kotlin("multiplatform") version "1.5.30"
}

repositories {
    jcenter()
}

kotlin {
    when (org.gradle.internal.os.OperatingSystem.current()!!.familyName) {
        "windows" -> mingwX64("native") {
            ext["include"] = "C:/msys64/mingw64/include"
            binaries.executable {
                baseName = "WA2_patch"
                entryPoint = "wa2en.main"
                linkerOpts(
                    "-LC:/msys64/mingw64/lib",
                    "-mwindows",
                    "-Wl,-Bstatic",
                    "-lstdc++",
                    "-static",
                    "-lcurl",
                    "-lidn2",
                    "-lssh2",
                    "-lpsl",
                    "-lbcrypt",
                    "-lcrypt32",
                    "-lwldap32",
                    "-lzstd",
                    "-lbrotlidec-static",
                    "-lbrotlicommon-static",
                    "-lz",
                    "-lws2_32",
                    "-lunistring",
                    "-liconv"
                )
                windres(projectDir.resolve("src/nativeMain/resources/wa2en.rc"))
            }
        }
        "linux" -> linuxX64("native") {
            ext["include"] = "/usr/include"
            binaries.executable {
                baseName = "WA2_patch"
                entryPoint = "wa2en.main"
                linkerOpts("-L/usr/lib")
            }
        }
        "os x" -> macosX64("native") {
            ext["include"] = "/usr/local/include"
            binaries.executable {
                baseName = "WA2_patch"
                entryPoint = "wa2en.main"
                linkerOpts("-L/usr/local/lib")
            }
        }
        else -> throw GradleException("Unsupported host")
    }.compilations["main"].cinterops {
        val libcurl by creating {
            includeDirs.headerFilterOnly(ext["include"] as String)
        }
        val libb2 by creating {
            includeDirs.headerFilterOnly(ext["include"] as String)
        }
        val wa2en by creating {
            includeDirs.headerFilterOnly(ext["include"] as String)
            includeDirs(defFile.parentFile.resolveSibling("include"))
        }
    }

    sourceSets.getByName("nativeMain") {
        dependencies {
            implementation("com.github.msink:libui:0.1.8")
            implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.5.2")
        }
    }
}

tasks {
    register<Delete>("cleanGenerated") {
        group = "templates"
        getByName("clean").dependsOn(this)
    }

    register<Exec>("mingwInstallLibb2") {
        commandLine("bash", "-c", """
        curl -LSs https://github.com/BLAKE2/libb2/releases/download/v0.98.1/libb2-0.98.1.tar.gz |
        tar xzf - && cd libb2-0.98.1 && autoreconf -fisv && ./configure --prefix=/c/msys64/mingw64
        --enable-fat --disable-native --build=x86_64-w64-mingw32 && make && make install
        """.trimIndent().replace('\n', ' '))
    }

    getByName("cinteropWa2enNative").dependsOn(generate(
            "wa2enHeader", "wa2en.h",
            "src/nativeInterop/include",
            "version" to version
    ))

    getByName("copyCinteropWa2enNative").dependsOn(generate(
            "wa2enResource", "wa2en.rc",
            "src/nativeMain/resources",
            "version" to "$version.0",
            "cversion" to "$version.0".replace('.', ',')
    ))

    withType<org.jetbrains.kotlin.gradle.tasks.KotlinNativeCompile> {
        kotlinOptions.freeCompilerArgs += "-opt"
    }

    withType<Wrapper> {
        gradleVersion = "7.2"
        distributionBase = Wrapper.PathBase.GRADLE_USER_HOME
        distributionType = Wrapper.DistributionType.BIN
        archiveBase = Wrapper.PathBase.GRADLE_USER_HOME
    }
}

fun TaskContainer.generate(
        name: String, source: String, dest: String, vararg tokens: Pair<String, Any?>
) = create<Copy>("generate${name.capitalize()}") {
    group = "templates"
    from(projectDir.resolve("src/templates/$source"))
    into(projectDir.resolve(dest))
    getByName<Delete>("cleanGenerated").delete(projectDir.resolve("$dest/$source"))
    filter<org.apache.tools.ant.filters.ReplaceTokens>("tokens" to mapOf(*tokens))
}


fun org.jetbrains.kotlin.gradle.plugin.mpp.Executable.windres(rcFile: File) {
    val taskName = linkTaskName.replaceFirst("link", "windres")
    val outFile = buildDir.resolve("processedResources/$taskName.res")
    val windresTask = tasks.create<Exec>(taskName) {
        val konanUserDir = System.getenv("KONAN_DATA_DIR")
                ?: "${System.getProperty("user.home")}/.konan"
        val konanLlvmDir = "$konanUserDir/dependencies/" +
                "msys2-mingw-w64-x86_64-clang-llvm-lld-compiler_rt-8.0.1/bin"
        inputs.file(rcFile)
        outputs.file(outFile)
        commandLine(
                "$konanLlvmDir/windres", rcFile.path, "-c", "65001",
                "-D_${buildType.name}", "-O", "coff", "-o", outFile.path
        )
        environment("PATH", "$konanLlvmDir;${System.getenv("PATH")}")
        dependsOn(compilation.compileKotlinTask)
    }
    linkTask.dependsOn(windresTask)
    linkerOpts(outFile.toString())
}
