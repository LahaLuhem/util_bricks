#!/usr/bin/env bash

cd "$(dirname "$0")" || exit
cd ../scanner/ || exit

if [ -f /.dockerenv ] && command -v flutter &> /dev/null; then
  flutter clean;
  dart pub get;
  flutter gen-l10n --template-arb-file=intl_en.arb;
  flutter build apk -t lib/main_dev.dart --flavor=develop --target-platform=android-arm64;
else
  fvm flutter clean;
  fvm dart pub get;
  fvm flutter gen-l10n --template-arb-file=intl_en.arb;
  fvm flutter build apk -t lib/main_dev.dart --flavor=develop --target-platform=android-arm64;
fi