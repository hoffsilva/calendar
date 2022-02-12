#!/bin/bashaa

set -eo pipefail

xcodebuild -project timetable.xcodeproj -scheme Data -destination 'platform=OS X' clean test