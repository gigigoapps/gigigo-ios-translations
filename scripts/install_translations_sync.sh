#!/bin/bash

originalPath=$(pwd)
echo "Downloading translations project in $originalPath"
# clone the project
git clone 'https://github.com/gigigoapps/gigigo-ios-translations.git'
cd gigigo-ios-translations
# build the project and export the archive
/usr/bin/xcodebuild -scheme translations-sync -project GIGTranslations.xcodeproj archive -archivePath ./translations-sync | xcpretty
cd translations-sync.xcarchive/Products/usr/local/bin/
mv translations-sync /usr/local/bin/
cd $originalPath
# remove the downloaded folder
rm -rf gigigo-ios-translations
echo 'The translations script has been installed'
