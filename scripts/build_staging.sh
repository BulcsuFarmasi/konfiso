#!/bin/bash

export APP_ENV=staging
echo $APP_ENV
flutter pub run build_runner build --delete-conflicting-outputs