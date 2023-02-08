#!/bin/bash

path_to_patches="$(pwd)"
build_home="${HOME}/android/floko"

cd ${build_home}/bootable/recovery
echo ">> [$(date)] Applying the patch to bootable/recovery"
patch --quiet --force -p1 -i "${path_to_patches}/bootable-recovery.patch"
git clean -fd

cd ${build_home}/build/make
echo ">> [$(date)] Applying the patch to build/make"
patch --quiet --force -p1 -i "${path_to_patches}/build-make.patch"
git clean -fd

cd ${build_home}/build/soong
echo ">> [$(date)] Applying the patch to build/soong"
patch --quiet --force -p1 -i "${path_to_patches}/build-soong.patch"
git clean -fd

cd ${build_home}/frameworks/base
echo ">> [$(date)] Applying the patch to frameworks/base"
patch --quiet --force -p1 -i "${path_to_patches}/frameworks-base.patch"
git clean -fd

cd ${build_home}/lineage-sdk
echo ">> [$(date)] Applying the patch to lineage-sdk"
find lineage/res/res/values*/strings.xml -type f | xargs sed -i -e "s/crDroid/FlokoROM/g"
git clean -fd

cd ${build_home}/packages/apps/crDroidSettings
echo ">> [$(date)] Applying the patch to packages/apps/crDroidSettings"
patch --quiet --force -p1 -i "${path_to_patches}/packages-apps-crDroidSettings.patch"
git clean -fd

cd ${build_home}/packages/apps/LineageParts
echo ">> [$(date)] Applying the patch to packages/apps/LineageParts"
find res/values*/strings.xml -type f | xargs sed -i -e "s/crDroid/FlokoROM/g"
git clean -fd

cd ${build_home}/packages/apps/Settings
echo ">> [$(date)] Applying the patch to packages/apps/Settings"
patch --quiet --force -p1 -i "${path_to_patches}/packages-apps-Settings.patch"
git clean -fd

cd ${build_home}/packages/apps/SetupWizard
echo ">> [$(date)] Applying the patch to packages/apps/SetupWizard"
patch --quiet --force -p1 -i "${path_to_patches}/packages-apps-SetupWizard.patch"
find res/values*/strings.xml -type f | xargs sed -i -e "s/crDroid/FlokoROM/g"
git clean -fd

cd ${build_home}/vendor/addons
echo ">> [$(date)] Applying the patch to vendor/addons"
patch --quiet --force -p1 -i "${path_to_patches}/vendor-addons.patch"
git clean -fd

cd ${build_home}/vendor/lineage
echo ">> [$(date)] Applying the patch to vendor/lineage"
patch --quiet --force -p1 -i "${path_to_patches}/vendor-lineage.patch"
git clean -fd
