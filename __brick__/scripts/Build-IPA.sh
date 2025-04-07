#!/usr/bin/env bash

cd "$(dirname "$0")" || exit
cd ../scanner/ || exit

if [ -f /.dockerenv ] && command -v flutter &> /dev/null; then
  flutter clean;
  dart pub get;
  flutter gen-l10n --template-arb-file=intl_en.arb;
  flutter build ipa -t lib/main_dev.dart --flavor=develop --export-method=development;
else
  fvm flutter clean;
  fvm dart pub get;
  fvm flutter gen-l10n --template-arb-file=intl_en.arb;
  fvm flutter build ipa -t lib/main_dev.dart --flavor=develop --export-method=development;
fi