@echo off
setlocal

if exist chromium\ (
  cd chromium                || goto error
  call gclient sync          || goto error
) else (
  echo please run env.cmd
  goto error
)

cd chromium\src
python3 tools/clang/scripts/build.py --bootstrap --without-android --without-fuchsia --disable-asserts --thinlto --pgo 

exit /B
:error
pause