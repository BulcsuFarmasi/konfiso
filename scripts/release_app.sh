#!/bin/bash

export APP_ENV=prod
flutter pub run build_runner build --delete-conflicting-outputs
flutter build appbundle -t lib/main_prod.dart --flavor prod --release
