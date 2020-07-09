#define WA2EN_VERSION "1.0.0"
#define WA2EN_USER_AGENT "WA2EnglishPatch/1.0.0"

#ifdef _WIN32
#include <windows.h>
#define WA2EN_LAUNCH_EXE 1
void start_exe(char const *exe) {
    STARTUPINFO info = { sizeof(info) };
    PROCESS_INFORMATION process;
    if (CreateProcess(exe, L"", NULL, NULL, TRUE,
            DETACHED_PROCESS, NULL, NULL, &info, &process)) {
        CloseHandle(process.hProcess);
        CloseHandle(process.hThread);
    }
}
#else
#define WA2EN_LAUNCH_EXE 0
void start_exe(char const *exe) {}
#endif
