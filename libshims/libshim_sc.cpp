#include <cstdint>
#include <cstddef>
#include <android/log.h>

#define LOG_TAG "libshim_sc"

extern "C" void* _ZN7android21SurfaceComposerClient13createSurfaceERKNS_7String8Ejjij(
        const void* /*name*/,
        unsigned int /*w*/,
        unsigned int /*h*/,
        int /*format*/,
        unsigned int /*flags*/) {
    __android_log_print(ANDROID_LOG_WARN, LOG_TAG, "shim: createSurface() called -> returning nullptr");
    return nullptr;
}

extern "C" void _ZN7android21SurfaceComposerClient21openGlobalTransactionEv() {
    __android_log_print(ANDROID_LOG_WARN, LOG_TAG, "shim: openGlobalTransaction() called -> no-op");
}

extern "C" void _ZN7android21SurfaceComposerClient22closeGlobalTransactionEb(unsigned char /*synchronous*/) {
    __android_log_print(ANDROID_LOG_WARN, LOG_TAG, "shim: closeGlobalTransaction() called -> no-op");
}

extern "C" void _ZN7android14SurfaceControl8setLayerEj(void* /*thisObj*/, unsigned int /*layer*/) {
    __android_log_print(ANDROID_LOG_WARN, LOG_TAG,
                        "shim: SurfaceControl::setLayer() called -> no-op");
}

extern "C" void _ZN7android14SurfaceControl11setPositionEff(void* /*thisObj*/, float x, float y) {
    __android_log_print(ANDROID_LOG_WARN, LOG_TAG,
                        "shim: SurfaceControl::setPosition(%.2f, %.2f) -> no-op", x, y);
}

extern "C" void _ZN7android14SurfaceControl7setSizeEjj(void* /*thisObj*/, unsigned int w, unsigned int h) {
    __android_log_print(ANDROID_LOG_WARN, LOG_TAG,
                        "shim: SurfaceControl::setSize(%u, %u) -> no-op", w, h);
}

extern "C" void _ZN7android14SurfaceControl4hideEv(void* /*thisObj*/) {
    __android_log_print(ANDROID_LOG_WARN, LOG_TAG,
                        "shim: SurfaceControl::hide() -> no-op");
}