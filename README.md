# WA2 English Patch

This is the Kotlin/Native rewrite of the patch.

## Ported features

* [x] Optional video downloads
* [x] Verify downloaded file checksums
* [ ] Automatically find installation folder
* [ ] Create `WA2_en` desktop shortcut
* [x] Launch `WA2_en` after installation
* [ ] Write operations to a log file
  * *Currently written to stdout*

## Added features

* [ ] Linux & OSX executables
  * *[Can be built manually](#build-instructions)*
* [ ] Create `WA2_en` by patching `WA2`

## Removed features

* Abort if `WA2` isn't found
* Edit `SYSTEM.ini`
* License agreement
* Release notes
* Instructions

## Build instructions

### Arch Linux

```sh
sudo pacman -S --needed jdk-openjdk curl libb2
git clone https://github.com/TodokanaiTL/WA2EnglishPatch
cd WA2EnglishPatch && git checkout rewrite
./gradlew runReleaseExecutableNative
```

### Ubuntu

```sh
sudo apt install default-jdk libcurl4-openssl-dev libb2-dev
git clone https://github.com/TodokanaiTL/WA2EnglishPatch
cd WA2EnglishPatch && git checkout rewrite
./gradlew runReleaseExecutableNative
```

### Fedora

```sh
sudo dnf in java-11-openjdk libcurl-devel libb2-devel
git clone https://github.com/TodokanaiTL/WA2EnglishPatch
cd WA2EnglishPatch && git checkout rewrite
./gradlew runReleaseExecutableNative
```

### MacOS

**TODO**

### Windows

**TODO**
