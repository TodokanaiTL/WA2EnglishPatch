group = "io.github.todokanaitl"
version = "1.0.0"

plugins {
    kotlin("multiplatform") version "1.4.20"
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
                linkerOpts("-LC:/msys64/mingw64/lib", "-mwindows")
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
            implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.4.2")
        }
    }
}

tasks {
    register<Delete>("cleanGenerated") {
        group = "templates"
        getByName("clean").dependsOn(this)
    }

    register<Exec>("mingwInstallLibcurl") {
        commandLine("bash", "-c", """
        curl https://curl.haxx.se/download/curl-7.73.0.tar.gz | tar xzf - && cd curl-7.73.0
        && ./configure CPPFLAGS='-DCURL_STATICLIB -DCARES_STATICLIB -DNGHTTP2_STATICLIB'
        --disable-manual --disable-proxy --disable-file --disable-ftp --disable-cookies
        --disable-smtp --disable-tftp --disable-pop3 --disable-imap --disable-unix-sockets
        --disable-dict --disable-telnet --disable-mqtt --disable-ldap --disable-ldaps
        --disable-rtsp --disable-http-auth --disable-gopher --disable-ipv6 --disable-netrc
        --disable-smb --disable-shared --enable-static --enable-ipv6 --enable-optimize
        --enable-ares --enable-esni --without-zstd --without-libpsl --without-libidn2
        --without-ssl --without-brotli --with-schannel --with-winidn --with-ca-fallback
        --build=x86_64-w64-mingw32 --prefix=/c/msys64/mingw64 && make && make install
        """.trimIndent().replace('\n', ' '))
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
        gradleVersion = "6.7"
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
