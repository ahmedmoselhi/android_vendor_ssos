PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    keyguard.no_require_sim=true \
    media.recorder.show_manufacturer_and_model=true \
    net.tethering.noprovisioning=true \
    persist.sys.disable_rescue=true \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.carrier=unknown \
    ro.com.android.dataroaming=false \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.config.bt_sco_vol_steps=30 \
    ro.config.media_vol_steps=30 \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.storage_manager.enabled=true \
    ro.com.google.ime.bs_theme=true \
    ro.com.google.ime.theme_id=5 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html

# Extra packages
PRODUCT_PACKAGES += \
    libjni_latinimegoogle

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_COPY_FILES += \
    vendor/ssos/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/ssos/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/ssos/prebuilt/common/bin/50-base.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-base.sh

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/ssos/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/ssos/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/ssos/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Blur properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/ssos/config/backup.xml:system/etc/sysconfig/backup.xml

# Fonts
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/ssos/fonts,$(TARGET_COPY_OUT_PRODUCT)/fonts)

# ShapeShiftOS-specific component overrides
PRODUCT_COPY_FILES += \
    vendor/ssos/config/component-overrides.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/component-overrides.xml

# Configs
PRODUCT_COPY_FILES += \
    vendor/ssos/prebuilt/common/etc/sysconfig/ssos-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/ssos-power-whitelist.xml \
    vendor/ssos/prebuilt/common/etc/sysconfig/dialer_experience.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/dialer_experience.xml \
    vendor/ssos/prebuilt/common/etc/sysconfig/turbo.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/turbo.xml

# Copy all ShapeShiftOS-specific init rc files
$(foreach f,$(wildcard vendor/ssos/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    Launcher3QuickStep

# Don't include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Permissions
PRODUCT_COPY_FILES += \
    vendor/ssos/prebuilt/common/etc/permissions/privapp-permissions-ssos-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-ssos.xml \
    vendor/ssos/prebuilt/common/etc/permissions/privapp-permissions-ssos.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-ssos.xml \
    vendor/ssos/prebuilt/common/etc/permissions/privapp-permissions-elgoog.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-elgoog.xml

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/ssos/overlay

# Inherit from apex config
$(call inherit-product, vendor/ssos/config/apex.mk)

# Inherit from audio config
$(call inherit-product, vendor/ssos/config/audio.mk)

# Inherit from accents config
$(call inherit-product, vendor/ssos/config/accents.mk)

# Inherit from fonts config
$(call inherit-product, vendor/ssos/config/fonts.mk)

# Inherit from packages config
$(call inherit-product, vendor/ssos/config/packages.mk)

# Inherit from bootanimation config
$(call inherit-product, vendor/ssos/config/bootanimation.mk)

# Inherit from rro_overlays config
$(call inherit-product, vendor/ssos/config/rro_overlays.mk)

# Inherit from our versioning
$(call inherit-product, vendor/ssos/config/versioning.mk)

# Inherit from GMS product config
$(call inherit-product, vendor/gms/gms_full.mk)

# Inherit from telephony config
$(call inherit-product, vendor/ssos/config/telephony.mk)
