#!/bin/bash

export APP_ENV=prod
echo $APP_ENV
flutter pub run build_runner build --delete-conflicting-outputs