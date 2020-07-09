package wa2en

import kotlinx.cinterop.*
import kotlinx.coroutines.*
import kotlin.native.concurrent.TransferMode
import kotlin.native.concurrent.Worker
import libui.*

val files = arrayOf(
        "WA2_en.exe", "en.pak", "ev000.pak", "ev150.pak",
        "IC/mv010.pak", "IC/mv020.pak", "IC/mv070.pak",
        "IC/mv080.pak", "IC/mv090.pak", "mv200.pak"
)

typealias Checkboxes = MutableList<CPointer<uiCheckbox>>

typealias ProgressBars = MutableMap<String, CPointer<uiProgressBar>>

data class Data(val checks: Checkboxes, val bars: ProgressBars, val folder: CPointer<uiEntry>)

@Suppress("UNUSED_PARAMETER")
fun patch(button: CPointer<uiButton>?, data: COpaquePointer?): Unit = runBlocking {
    with(data!!.asStableRef<Data>().get()) {
        val window = uiControlParent(uiControlParent(
                uiControlParent(folder.reinterpret())
        ))!!.reinterpret<uiWindow>()
        val text = uiEntryText(folder)!!
        val location = text.toKString()
        uiFreeText(text)
        if (location.isEmpty()) {
            return@with uiMsgBoxError(
                    window, "Error", "Please select the game folder first!"
            )
        }
        for (check in checks.filter { uiCheckboxChecked(it) == 1 }) {
            launch(Dispatchers.Default) {
                val label = uiCheckboxText(check)!!
                val name = label.toKString()
                uiFreeText(label)
                val file = File("$location/$name")
                if (name != "WA2_en.exe" && name != "en.pak") {
                    if (File.exists("$file.bkp"))
                        return@launch uiProgressBarSetValue(bars[name], 100)
                    try {
                        file.rename("$file.bkp")
                    } catch (err: Error.Posix) {
                        println("[ERROR] ${err.message}")
                        return@launch uiMsgBoxError(window, "${err.type} Error", err.message)
                    }
                }
                val curl = CURL(file, name, window, bars[name]!!)
                Worker.start(name = name).execute(TransferMode.UNSAFE, { curl }) {
                    try {
                        println("[INFO] ${it.file}: ${it.fetch()}")
                    } catch (err: Error) {
                        println("[ERROR] ${err.message}")
                        uiMsgBoxError(it.window, "${err.type} Error", err.message)
                    } catch (exc: Throwable) {
                        print("[ERROR] ")
                        exc.printStackTrace()
                        uiMsgBoxError(it.window, exc::class.simpleName ?: "Error", exc.message)
                    } finally {
                        it.close()
                    }
                }
            }
        }
    }
}

fun main() = memScoped {
    val options = alloc<uiInitOptions>()
    val init = uiInit(options.ptr)
    if (init != null) {
        val error = init.toKString()
        uiFreeInitError(init)
        error("[ERROR] $error")
    }
    val window = uiNewWindow("WA2 English Patch", 720, 480, 1)
    uiWindowSetMargined(window, 1)
    val vbox = uiNewVerticalBox()!!
    uiBoxSetPadded(vbox, 1)
    uiWindowSetChild(window, vbox.reinterpret())
    val hbox = uiNewHorizontalBox()!!
    uiBoxSetPadded(hbox, 1)
    uiBoxAppend(vbox, hbox.reinterpret(), 0)
    val folder = uiNewEntry()!!
    uiBoxAppend(hbox, folder.reinterpret(), 1)
    val browse = uiNewButton("Browse")!!
    uiBoxAppend(hbox, browse.reinterpret(), 0)
    uiButtonOnClicked(browse, staticCFunction {
        _: CPointer<uiButton>?, ptr: COpaquePointer? ->
        val value = uiOpenFolder(uiControlParent(uiControlParent(
                uiControlParent(ptr!!.reinterpret())
        ))!!.reinterpret())
        if (value != null) {
            val text = value.toKString()
            uiFreeText(value)
            uiEntrySetText(ptr.reinterpret(), text)
        }
    }, folder)
    val checkboxes: Checkboxes = mutableListOf()
    val progressBars: ProgressBars = mutableMapOf()
    for (name in files) {
        val box = uiNewHorizontalBox()!!
        uiBoxSetPadded(box, 1)
        uiBoxAppend(vbox, box.reinterpret(), 0)
        val check = uiNewCheckbox(name)!!
        uiBoxAppend(box, check.reinterpret(), 1)
        uiCheckboxSetChecked(check, 1)
        if (name == "WA2_en.exe" || name == "en.pak")
            uiControlDisable(check.reinterpret())
        checkboxes += check
        val bar = uiNewProgressBar()!!
        uiBoxAppend(box, bar.reinterpret(), 1)
        progressBars[name] = bar
    }
    val btns = uiNewHorizontalBox()!!
    uiBoxSetPadded(btns, 1)
    uiBoxAppend(vbox, btns.reinterpret(), 0)
    val install = uiNewButton("Install selected")!!
    uiBoxAppend(btns, install.reinterpret(), 1)
    val data = StableRef.create(Data(checkboxes, progressBars, folder)).asCPointer()
    uiButtonOnClicked(install, staticCFunction(::patch), data)
    @Suppress("ConstantConditionIf")
    if (WA2EN_LAUNCH_EXE == 1) {
        val launch = uiNewButton("Launch WA2_en.exe")!!
        uiBoxAppend(btns, launch.reinterpret(), 1)
        uiButtonOnClicked(launch, staticCFunction {
            _: CPointer<uiButton>?, ptr: COpaquePointer? ->
            val text = uiEntryText(ptr!!.reinterpret())!!
            val location = text.toKString()
            uiFreeText(text)
            if (location.isEmpty()) {
                return@staticCFunction uiMsgBoxError(uiControlParent(
                        uiControlParent(uiControlParent(ptr.reinterpret()))
                )!!.reinterpret(), "Error", "Please select the game folder first!")
            }
            start_exe("$location/WA2_en.exe")
        }, folder)
    }
    uiWindowOnClosing(window, staticCFunction {
        _: CPointer<uiWindow>?, ptr: COpaquePointer? ->
        ptr!!.asStableRef<Data>().dispose()
        uiQuit()
        1
    }, data)
    uiControlShow(window!!.reinterpret())
    uiMain()
    uiUninit()
}
