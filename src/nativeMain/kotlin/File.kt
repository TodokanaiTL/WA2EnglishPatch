package wa2en

import kotlinx.cinterop.*
import platform.posix.*

class File(private val path: String) {
    var ptr: CPointer<FILE>? = null
        private set

    @Throws(Error.Posix::class)
    fun open(mode: String): CPointer<FILE> {
        ptr = fopen(path, mode)
        return ptr ?: throw Error.Posix("Failed to open $path")
    }

    @Throws(Error.Posix::class)
    fun close() {
        if (fclose(ptr) == -1)
            throw Error.Posix("Failed to close $path")
    }

    @Throws(Error.Posix::class)
    fun rename(name: String) {
        if (rename(path, name) == -1)
            throw Error.Posix("Failed to rename $path to $name")
    }

    override fun toString() = path

    companion object {
        fun exists(path: String) = access(path, F_OK) != -1
    }
}
