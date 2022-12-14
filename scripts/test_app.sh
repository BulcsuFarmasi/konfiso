#!/bin/bash

flutter test --coverage
flutter test integration_test --coverage --flavor dev
genhtml ./coverage/lcov.info -o ./coverage/html
lcov-badge ./coverage/lcov.info -o ./coverage/badge.svg