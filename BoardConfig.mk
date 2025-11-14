#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/blackberry/venice

TARGET_SPECIFIC_HEADER_PATH := $(DEVICE_PATH)/include

# Platform
TARGET_BOARD_PLATFORM := msm8992
TARGET_BOOTLOADER_BOARD_NAME := venice

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

# Audio
AUDIO_FEATURE_ENABLED_COMPRESS_VOIP := true
AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT := true
AUDIO_FEATURE_ENABLED_EXTN_FORMATS := true
AUDIO_FEATURE_ENABLED_FLAC_OFFLOAD := true
AUDIO_FEATURE_ENABLED_FLUENCE := true
AUDIO_FEATURE_ENABLED_HFP := true
AUDIO_FEATURE_ENABLED_KPI_OPTIMIZE := true
AUDIO_FEATURE_ENABLED_LOW_LATENCY_CAPTURE := true
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
AUDIO_FEATURE_ENABLED_PCM_OFFLOAD := true
AUDIO_FEATURE_ENABLED_PCM_OFFLOAD_24 := true
AUDIO_FEATURE_ENABLED_PROXY_DEVICE := true
TARGET_USES_QCOM_MM_AUDIO := true
# A2DP offload enabled for compilation
AUDIO_FEATURE_ENABLED_A2DP_OFFLOAD := true

# A2DP offload supported
# PRODUCT_PROPERTY_OVERRIDES += \
# ro.bluetooth.a2dp_offload.supported=true

# A2DP offload disabled (UI toggle property)
# PRODUCT_PROPERTY_OVERRIDES += \
# persist.bluetooth.a2dp_offload.disabled=false

# A2DP offload DSP supported encoder list
# PRODUCT_PROPERTY_OVERRIDES += \
# persist.bluetooth.a2dp_offload.cap=sbc-aac-aptx-aptxhd-ldac

AUDIO_USE_LL_AS_PRIMARY_OUTPUT := true
BOARD_USES_ALSA_AUDIO := true
USE_CUSTOM_AUDIO_POLICY := 1

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth
BOARD_CUSTOM_BT_CONFIG := $(DEVICE_PATH)/bluetooth/vnd_venice.txt
# BOARD_HAVE_BLUETOOTH_BCM := true

# Camera
TARGET_PROCESS_SDK_VERSION_OVERRIDE := \
    /system/vendor/bin/mm-qcamera-daemon=23

# Charger
BOARD_CHARGER_ENABLE_SUSPEND := true

# Power
TARGET_USES_INTERACTION_BOOST := true
TARGET_USES_NON_LEGACY_POWERHAL := true

# Dexpreopt
WITH_DEXPREOPT_DEBUG_INFO := false

# Rendering
OVERRIDE_RS_DRIVER:= libRSDriver_adreno.so
TARGET_SCREEN_DENSITY := 580
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS := 0x02000000
TARGET_DISABLE_POSTRENDER_CLEANUP := true
MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024
USE_OPENGL_RENDERER := true
HAVE_ADRENO_SOURCE:= false
TARGET_USES_ION := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_HWC2 := true

# Gralloc / HWC
TARGET_USES_GRALLOC1_ADAPTER := true

# Vsync
VSYNC_EVENT_PHASE_OFFSET_NS := 2000000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 6000000
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# Encryption
TARGET_HW_DISK_ENCRYPTION := true

# Keymaster
# TARGET_PROVIDES_KEYMASTER := true

# Filesystem
BOARD_BOOTIMAGE_PARTITION_SIZE     := 50327552
BOARD_CACHEIMAGE_PARTITION_SIZE    := 536870912
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 50327552
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 3758096384
BOARD_USERDATAIMAGE_PARTITION_SIZE := 26168245760

BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE    := f2fs
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_ROOT_EXTRA_FOLDERS := firmware persist nvram nvram/blog nvram/perm nvram/nvuser nvram/prdid nvram/boardid

TARGET_FS_CONFIG_GEN := $(DEVICE_PATH)/config.fs

#GPS
#BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE
#TARGET_USES_HARDWARE_QCOM_GPS := true
#BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := msm8992
#BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET := true

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml

# IPA
USE_DEVICE_SPECIFIC_DATA_IPA_CFG_MGR := true

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE :=  4096
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET     := 0x01000000
BOARD_RAMDISK_USE_XZ := true

TARGET_KERNEL_SOURCE := kernel/blackberry/msm8992
TARGET_KERNEL_CONFIG := lineageos_venice_defconfig
TARGET_KERNEL_ARCH := arm64
BOARD_KERNEL_CMDLINE := console=null androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 boot_cpus=0-5 loop.max_part=7 androidboot.selinux=permissive
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_SEPARATED_DT := true
BOARD_CUSTOM_MKBOOTIMG := $(DEVICE_PATH)/bootimg/mkbootimg.py
BOARD_MKBOOTIMG_ARGS := --binfo $(DEVICE_PATH)/bootimg/binfo.img
BOARD_RECOVERY_MKBOOTIMG_ARGS := $(BOARD_MKBOOTIMG_ARGS) --recovery

TARGET_USES_64_BIT_BINDER := true

# Legacy memfd
TARGET_HAS_MEMFD_BACKPORT := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# QCOM
BOARD_USES_QCOM_HARDWARE := true

# Radio
TARGET_USES_OLD_MNC_FORMAT := true
BOARD_PROVIDES_LIBRIL := true

# Recovery
TARGET_RECOVERY_DEVICE_DIRS += $(DEVICE_PATH)
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/fstab.qcom

# SELinux
include device/qcom/sepolicy-legacy/sepolicy.mk
BOARD_SEPOLICY_DIRS += \
    $(DEVICE_PATH)/sepolicy

# Shims
TARGET_LD_SHIM_LIBS := \
    /vendor/bin/cnd|libcutils_shim.so \
    /vendor/lib64/libcne.so|libcutils_shim.so \
    /system/vendor/lib64/libril-qc-qmi-1.so|libaudioclient_shim.so \
    /vendor/lib/libwvhidl.so|/vendor/lib/libprotobuf-cpp-lite-v29.so \
    /vendor/lib/mediadrm/libwvdrmengine.so|/vendor/lib/libprotobuf-cpp-lite-v29.so \
    /vendor/bin/hw/android.hardware.drm@1.0-service.widevine|libshim_drm.so \
    /system/vendor/lib/libllvd_smore.so|libcamera_shim.so \
    /system/vendor/lib/libmmcamera_chromaflash_lib.so|libcamera_shim.so \
    /system/vendor/lib/libmmcamera_stillmore_lib.so|libcamera_shim.so \
    /system/vendor/lib/lib-sec-disp.so|libshim_sc.so \

# WiFi
BOARD_WLAN_DEVICE           := bcmdhd
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_BUS := PCIE
WIFI_DRIVER_FW_PATH_AP      := "/vendor/firmware/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION      := VER_0_8_X

# Inherit from the proprietary version
include vendor/blackberry/venice/BoardConfigVendor.mk
