#!/bin/bash

export APP_ENV=prod
fvm flutter pub run build_runner build --delete-conflicting-outputs
fvm flutter build appbundle -t lib/main_prod.dart --flavor prod --release
