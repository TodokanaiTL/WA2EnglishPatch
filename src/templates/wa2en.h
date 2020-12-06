#define WA2EN_VERSION "@version@"
#define WA2EN_USER_AGENT "WA2EnglishPatch/@version@"

#ifdef _WIN32
#include <windows.h>
#define WA2EN_LAUNCH_EXE 1
void start_exe(char const *exe) {
    LPSTARTUPINFO lpStartupInfo;
    LPPROCESS_INFORMATION lpProcessInfo;
    memset(&lpStartupInfo, 0, sizeof lpStartupInfo);
    memset(&lpProcessInfo, 0, sizeof lpProcessInfo);
    CreateProcess(exe, NULL, NULL, NULL, NULL,
            CREATE_DEFAULT_ERROR_MODE | CREATE_NEW_PROCESS_GROUP,
            NULL, NULL, lpStartupInfo, lpProcessInfo);
}
#else
#define WA2EN_LAUNCH_EXE 0
void start_exe(char const *exe) {}
#endif
