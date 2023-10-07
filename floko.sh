#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

if [ $# = 1 ]; then
    if [ $(echo $1 | sed -e 's/ //g' | rev | cut -c 1 ) == "/" ]; then
        build_home=$(echo $1 | rev | sed -e 's@/@@' | rev )
    else
        build_home=$1
    fi
elif [ -f $ANDROID_BUILD_TOP/.repo/manifests/snippets/crdroid.xml ]; then
	build_home=$ANDROID_BUILD_TOP
else
	build_home="${HOME}/android/floko"
fi
echo $build_home
patch_dir="$(pwd)"

apply_patch() {
    cd ${build_home}/${1}
    echo ">> [$(date)] Applying the patch to ${1}"
    patch_file=$(echo ${1} | sed 's@/@_@g')
    git apply -p1 "${patch_dir}/${patch_file}.diff"
}

for patch_dest in $(cat patch.txt); do
    apply_patch ${patch_dest}

    if [ "${patch_dest}" = "frameworks/base" ]; then
        # This is workaround; If the patch failed because something changed in upstream, remove this file anyway.
        echo ">> [$(date)] -- Removing PixelPropsUtils.java"
        git rm core/java/com/android/internal/util/crdroid/PixelPropsUtils.java

    elif [ "${patch_dest}" = "lineage-sdk" ]; then
        echo ">> [$(date)] -- Rebranding crDroid to FlokoROM"
        find lineage/res/res/values*/strings.xml -type f | xargs sed -i -e "s/crDroid/FlokoROM/g"

    elif [ "${patch_dest}" = "packages/apps/LineageParts" ] || [ "${patch_dest}" = "packages/apps/SetupWizard" ]; then
        echo ">> [$(date)] -- Rebranding crDroid to FlokoROM"
        find res/values*/strings.xml -type f | xargs sed -i -e "s/crDroid/FlokoROM/g"

    elif [ "${patch_dest}" = "vendor/lineage" ]; then
        # This is workaround; If the patch failed because something changed in upstream, remove this file anyway.
        echo ">> [$(date)] -- Removing version.mk"
        git rm config/version.mk
    fi
done
