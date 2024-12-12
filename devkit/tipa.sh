#!/bin/sh

XCCONFIG_NAME=TrollFools/Version.xcconfig
VERSION=$(awk -F "=" '/VERSION/ {print $2}' $XCCONFIG_NAME | tr -d ' ')
BUILD_NUMBER=$(awk -F "=" '/BUILD_NUMBER/ {print $2}' $XCCONFIG_NAME | tr -d ' ')

mkdir -p packages $THEOS_STAGING_DIR/Payload
cp -rp $THEOS_STAGING_DIR$THEOS_PACKAGE_INSTALL_PREFIX/Applications/TrollFools.app $THEOS_STAGING_DIR/Payload
chmod 0644 $THEOS_STAGING_DIR/Payload/TrollFools.app/Info.plist
rm $THEOS_STAGING_DIR/Payload/TrollFools.app/ldid-14 || true

cd $THEOS_STAGING_DIR
7z a -tzip -mm=LZMA TrollFools_$VERSION-$BUILD_NUMBER.tipa Payload
cd -

cp -p TrollFools/ldid-14 $THEOS_STAGING_DIR/Payload/TrollFools.app/ldid-14

cd $THEOS_STAGING_DIR
zip -qr TrollFools14_$VERSION-$BUILD_NUMBER.tipa Payload
cd -

cp -p $THEOS_STAGING_DIR/TrollFools_$VERSION-$BUILD_NUMBER.tipa $THEOS_STAGING_DIR/TrollFools14_$VERSION-$BUILD_NUMBER.tipa packages
