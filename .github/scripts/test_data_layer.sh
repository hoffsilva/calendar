#!/bin/bash

set -eo pipefail

xcodebuild -project timetable.xcodeproj -scheme Data -destination 'platform=OS X' -allowProvisioningUpdates clean test