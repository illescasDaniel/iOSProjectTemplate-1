#!/bin/sh

periphery scan \
--project "${SRCROOT}/TestProject1.xcodeproj/" \
--schemes "TestProject1" \
--targets "TestProject1" \
--no-retain-public
--format xcode
