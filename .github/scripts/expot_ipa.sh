#!/bin/bash

set -eo pipefail

xcodebuild -archivePath $PWD/build/timetable.xcarchive -exportOptionsPlist timetable/exportOptions.plist -exportPath $PWD/build -allowProvisioningUpdates -exportArchive