@echo off
setlocal

cd chromium\src
python3 tools/clang/scripts/build.py --bootstrap --without-android --without-fuchsia --disable-asserts --thinlto --pgo 