@echo off
setlocal

set ROOT_DIR=%~dp0
set PATH=%ROOT_DIR%\depot_tools;%PATH%
set DEPOT_TOOLS_WIN_TOOLCHAIN=0
set NINJA_SUMMARIZE_BUILD=1

call vswhere -latest -format value -property installationPath > %TMP%\chromeenv.txt
set /P vs2022_install=<%TMP%\chromeenv.txt
rm %TMP%\chromeenv.txt

call gclient exit || goto error

call git config --global core.autocrlf false
call git config --global core.filemode false
call git config --global branch.autosetuprebase always
call git config --global core.longpaths true

call cmd