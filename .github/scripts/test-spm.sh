#!/bin/bash

set -eo pipefail

cd Resolver-package; swift test --parallel; cd ..