#define WA2EN_VERSION "@version@"
#define WA2EN_USER_AGENT "WA2EnglishPatch/@version@"

#ifdef _WIN32
#include <windows.h>
#define WA2EN_LAUNCH_EXE 1
static inline void start_exe(char const *exe, char const *dir) {
    ShellExecute(NULL, "open", exe, NULL, dir, SW_SHOW);
}
#else
#define WA2EN_LAUNCH_EXE 0
static inline void start_exe(char const *exe, char const *dir) {}
#endif
