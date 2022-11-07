#!/bin/bash

export APP_ENV=staging
flutter pub run build_runner build --delete-conflicting-outputs