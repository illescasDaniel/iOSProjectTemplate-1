#!/bin/sh

periphery scan \
--project "${SRCROOT}/ProjectTemplate.xcodeproj/" \
--schemes "TestProject1" \
--targets "TestProject1" \
--no-retain-public
--format xcode
