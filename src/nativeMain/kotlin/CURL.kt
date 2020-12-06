package wa2en

import kotlinx.cinterop.*
import libcurl.*
import libui.uiProgressBar
import libui.uiProgressBarSetValue
import libui.uiWindow
import platform.posix.fwrite
import platform.posix.size_t

class CURL(
        val file: File,
        private val name: String,
        val window: CPointer<uiWindow>,
        private val bar: CPointer<uiProgressBar>
) {
    private val curl = curl_easy_init()

    private val urls = mapOf(
            "en.pak" to "https://www.dropbox.com/s/dl/rkl4hwij4mshef2/en.pak",
            "ev000.pak" to "https://cloud.disroot.org/s/GSJAI3ImXkKyhTU/download",
            "ev150.pak" to "https://cloud.disroot.org/s/ytHgR2d9smdEobF/download",
            "IC/mv010.pak" to "https://cloud.disroot.org/s/sRAzdd4ccW7lTok/download",
            "IC/mv020.pak" to "https://cloud.disroot.org/s/3ogQTfqSrShs92j/download",
            "IC/mv070.pak" to "https://cloud.disroot.org/s/FTF5wxZXOlPdEQx/download",
            "IC/mv080.pak" to "https://cloud.disroot.org/s/SvvMcAjsTSy9z1H/download",
            "IC/mv090.pak" to "https://cloud.disroot.org/s/b7DlHjPRgro8wyp/download",
            "mv200.pak" to "https://cloud.disroot.org/s/kDDSTHYUEi6wRP2/download",
            // TODO: move this out of the repo
            "WA2_en.exe" to "https://raw.githubusercontent.com/TodokanaiTL/WA2EnglishPatch/master/bin/WA2_en.exe"
    )

    init {
        curl_easy_setopt(curl, CURLOPT_VERBOSE, true)
        curl_easy_setopt(curl, CURLOPT_URL, urls[name])
        curl_easy_setopt(curl, CURLOPT_XFERINFODATA, bar)
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, true)
        curl_easy_setopt(curl, CURLOPT_USERAGENT, WA2EN_USER_AGENT)
    }

    @Throws(Error::class)
    fun fetch(): String {
        if (name == "en.pak") {
            uiProgressBarSetValue(bar, -1)
            curl_easy_setopt(curl, CURLOPT_NOPROGRESS, true)
        } else {
            curl_easy_setopt(curl, CURLOPT_NOPROGRESS, false)
            curl_easy_setopt(curl, CURLOPT_XFERINFOFUNCTION, staticCFunction {
                ptr: COpaquePointer?, total: curl_off_t, now: curl_off_t, _: curl_off_t, _: curl_off_t ->
                if (total != 0L)
                    uiProgressBarSetValue(ptr!!.reinterpret(), (100.0 * now / total).toInt())
                0
            })
        }
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, file.open("wb"))
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, staticCFunction {
            ptr: COpaquePointer?, size: size_t, nmemb: size_t, stream: COpaquePointer? ->
            if (ptr == null) 0.convert() else fwrite(ptr, size, nmemb, stream!!.reinterpret())
        })
        val code = curl_easy_perform(curl)
        file.close()
        if (code != CURLcode.CURLE_OK)
            throw Error.HTTP("Failed to download ${urls[name]} to $file", code)
        if (name == "en.pak") uiProgressBarSetValue(bar, 100)
        return BLAKE2.verify(file, name)
    }

    fun close() = curl_easy_cleanup(curl)
}
