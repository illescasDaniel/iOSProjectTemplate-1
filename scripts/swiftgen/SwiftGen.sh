#!/bin/sh

#export PROJ_ROOT="../../TestProject1"
export PROJ_ROOT="${SRCROOT}/TestProject1"

export RESOURCES="${PROJ_ROOT}/resources"

export LOCALIZATION="${RESOURCES}/L10n"
export STRINGS="${LOCALIZATION}/Base.lproj"

export ASSETS_ROOT="${RESOURCES}/assets"
export ASSETS="${ASSETS_ROOT}/Assets.xcassets"

export COLORS_ROOT="${RESOURCES}/colors"
export COLORS="${COLORS_ROOT}/sources"

export FONTS_ROOT="${RESOURCES}/fonts"
export FONTS="${FONTS_ROOT}/sources"

swiftgen
