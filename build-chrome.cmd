@echo off
setlocal

if exist chromium\ (
  cd chromium                || goto error
  call gclient sync          || goto error
  cd src                     || goto error
) else (
  echo please run env.cmd
  goto error
)

call python3 tools/update_pgo_profiles.py --target=win64 update --gs-url-base=chromium-optimization-profiles/pgo_profiles                    || goto error
call gn gen out\Default --args="blink_symbol_level = 0 v8_symbol_level = 0 symbol_level = 0 is_official_build = true chrome_pgo_phase = 2"   || goto error
call autoninja -C out\Default base
call autoninja -C out\Default chrome

echo Done!

:error
pause