@echo off
chcp 65001

jq -c -r -s -f main.jq direction.json typhoon1005.json beaufort_wind.json