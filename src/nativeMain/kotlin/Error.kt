package wa2en

import kotlinx.cinterop.toKString
import libcurl.CURLcode
import libcurl.curl_easy_strerror
import platform.posix.errno
import platform.posix.strerror

sealed class Error(message: String, val type: String) : Throwable(message) {
    class HTTP(message: String, code: CURLcode) :
            Error("$message: ${curl_easy_strerror(code)?.toKString() ?: code}", "HTTP")

    class Posix(message: String, type: String = "I/O") :
            Error("$message: ${strerror(errno)?.toKString() ?: "Unknown error"}", type)

    class Hash(message: String) : Error(message, "Verification")
}
