#!/bin/bash

set -eo pipefail

xcodebuild -project timetable.xcodeproj -scheme UI -destination 'platform=iOS Simulator,name=iPhone 13 Pro Max' clean test