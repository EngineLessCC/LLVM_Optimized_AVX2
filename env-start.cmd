@echo off
setlocal

set ROOT_DIR=%~dp0
set PATH=%ROOT_DIR%\depot_tools;%PATH%
set DEPOT_TOOLS_WIN_TOOLCHAIN=0
set NINJA_SUMMARIZE_BUILD=1

if exist vswhere.exe (
  REM nothing
) else (
  curl -f -L https://github.com/microsoft/vswhere/releases/latest/download/vswhere.exe -o vswhere.exe || goto error
)

call vswhere -latest -format value -property installationPath > %TMP%\chromeenv.txt                   || goto error
set /P vs2022_install=<%TMP%\chromeenv.txt                                                            || goto error
rm %TMP%\chromeenv.txt                                                                                || goto error
																							          
if exist depot_tools\ (                                                                               
  REM nothing                                                                                         
) else (                                                                                              
  curl -f -L https://storage.googleapis.com/chrome-infra/depot_tools.zip -o depot_tools.zip           || goto error
  unzip depot_tools -d depot_tools                                                                    || goto error
  rm depot_tools.zip                                                                                  || true
  cd depot_tools                                                                                      || true
  call git config core.autocrlf false                                                                 || true
  call git config core.filemode false                                                                 || true
  call git config branch.autosetuprebase always                                                       || true
  call git config core.longpaths true                                                                 || true																						          
  call gclient root                                                                                     || goto error
  cd..
)                                                                                                     

if exist chromium\ (
  REM nothing
) else (
  mkdir chromium                                                                                      || goto error
  cd chromium                                                                                         || goto error
  call fetch --no-history chromium                                                                    || goto error
  call git config core.fsmonitor true                                                                 || true
  call git config core.untrackedCache true                                                            || true
  call git config core.autocrlf false                                                                 || true
  call git config core.filemode false                                                                 || true
  call git config branch.autosetuprebase always                                                       || true
  call git config core.longpaths true                                                                 || true
  cd ..                                                                                               || goto error
)

echo .
echo .
echo Done! You can now build LLVM and Chromium using the source tree.
echo .
echo .
call cmd

exit /B
:error
pause