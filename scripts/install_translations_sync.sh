#!/bin/bash

echo 'Downloading translations project'
git clone -b develop 'https://github.com/jerilyngigigo/gigigo-tranlations-ios-lib.git'
cd gigigo-tranlations-ios-lib/scripts
mv translations-sync /usr/local/bin/
cd ../../
rm -rf gigigo-tranlations-ios-lib
echo 'The translations script has been installed'
