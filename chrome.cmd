@echo off
setlocal

mkdir chromium || true
cd chromium && call fetch --no-history chromium || call gclient sync || goto error
cd src

call git config core.fsmonitor true
call git config core.untrackedCache true

call gn gen out\Default --args="blink_symbol_level = 0 v8_symbol_level = 0 symbol_level = 0 is_official_build = true chrome_pgo_phase = 0"
call autoninja -C out\Default base
call autoninja -C out\Default chrome

echo Done!
:error
pause