#!/usr/bin/env bash

xcodebuild docbuild -scheme Pinnable -destination generic/platform=iOS OTHER_DOCC_FLAGS="--transform-for-static-hosting --hosting-base-path Pinnable --output-path docs"
