@echo off
setlocal

rm vswhere.exe                                                                                      || true
curl -f -L https://github.com/microsoft/vswhere/releases/latest/download/vswhere.exe -o vswhere.exe || goto error

call gclient root                                                                                   || goto error

if exist chromium\ (
  cd chromium                                                                                       || goto error
  call gclient sync                                                                                 || goto error
) else (
  echo please run env.cmd
  goto error
)

exit /B
:error
pause