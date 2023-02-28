#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

build_home="${HOME}/android/floko"
path_to_patches="$(pwd)"

apply_patch() {
    echo ">> [$(date)] Applying the patch to $(pwd | sed 's@.*floko/@@g')"
    git apply -p1 "${path_to_patches}/${1}.diff"
}

cd ${build_home}/bootable/recovery
apply_patch bootable_recovery

cd ${build_home}/build/make
apply_patch build

cd ${build_home}/build/soong
apply_patch build_soong

cd ${build_home}/frameworks/base
apply_patch frameworks_base
# This is workaround; If the patch failed because something changed in upstream, remove this file anyway.
echo ">> [$(date)] -- Removing PixelPropsUtils.java"
git rm core/java/com/android/internal/util/crdroid/PixelPropsUtils.java

cd ${build_home}/lineage-sdk
apply_patch lineage-sdk
echo ">> [$(date)] -- Rebranding crDroid to FlokoROM"
find lineage/res/res/values*/strings.xml -type f | xargs sed -i -e "s/crDroid/FlokoROM/g"

cd ${build_home}/packages/apps/crDroidSettings
apply_patch packages_apps_crDroidSettings

cd ${build_home}/packages/apps/LineageParts
apply_patch packages_apps_LineageParts
echo ">> [$(date)] -- Rebranding crDroid to FlokoROM"
find res/values*/strings.xml -type f | xargs sed -i -e "s/crDroid/FlokoROM/g"

cd ${build_home}/packages/apps/Settings
apply_patch packages_apps_Settings

cd ${build_home}/packages/apps/SetupWizard
apply_patch packages_apps_SetupWizard
echo ">> [$(date)] -- Rebranding crDroid to FlokoROM"
find res/values*/strings.xml -type f | xargs sed -i -e "s/crDroid/FlokoROM/g"

cd ${build_home}/vendor/addons
apply_patch vendor_addons

cd ${build_home}/vendor/lineage
apply_patch vendor_lineage
# This is workaround; If the patch failed because something changed in upstream, remove this file anyway.
echo ">> [$(date)] -- Removing version.mk"
git rm config/version.mk
