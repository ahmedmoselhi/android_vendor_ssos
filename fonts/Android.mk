#
# Copyright (C) 2018 The Pixel3ROM Project
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

LOCAL_PATH := $(call my-dir)

################################
# Build font files as prebuilt.

# $(1): The source file name in LOCAL_PATH.
#       It also serves as the module name and the dest file name.
define build-one-font-module
$(eval include $(CLEAR_VARS))\
$(eval LOCAL_MODULE := $(1))\
$(eval LOCAL_SRC_FILES := $(1))\
$(eval LOCAL_MODULE_CLASS := ETC)\
$(eval LOCAL_MODULE_TAGS := optional)\
$(eval LOCAL_PRODUCT_MODULE := true)\
$(eval LOCAL_MODULE_PATH := $(TARGET_OUT_PRODUCT)/fonts)\
$(eval include $(BUILD_PREBUILT))
endef

font_src_files := \
    GoogleSans-BoldItalic.ttf \
    GoogleSans-Bold.ttf \
    GoogleSans-Italic.ttf \
    GoogleSans-MediumItalic.ttf \
    GoogleSans-Medium.ttf \
    GoogleSans-Regular.ttf \
    Inter-Black.otf \
    Inter-ExtraBold.otf \
    Inter-Italic.otf \
    Inter-MediumItalic.otf \
    Inter-Thin.otf \
    Inter-BlackItalic.otf \
    Inter-ExtraBoldItalic.otf \
    Inter-Light.otf \
    Inter-Regular.otf \
    Inter-ThinItalic.otf \
    Inter-Bold.otf \
    Inter-ExtraLight.otf \
    Inter-LightItalic.otf \
    Inter-SemiBold.otf \
    Inter-BoldItalic.otf \
    Inter-ExtraLightItalic.otf \
    Inter-Medium.otf \
    Inter-SemiBoldItalic.otf

$(foreach f, $(font_src_files), $(call build-one-font-module, $(f)))

build-one-font-module :=
font_src_files :=

