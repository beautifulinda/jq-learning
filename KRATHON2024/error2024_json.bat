@echo off
chcp 65001

jq -c -r -s -f main_error.jq direction.json typhoon0930.json beaufort_wind.json