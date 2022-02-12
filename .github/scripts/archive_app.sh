#!/bin/bash

set -eo pipefail

xcodebuild -project timetable.xcodeproj -scheme timetable_ios -sdk iphoneos -configuration AppStoreDistribution -archivePath $PWD/build/timetable.xcarchive clean archive