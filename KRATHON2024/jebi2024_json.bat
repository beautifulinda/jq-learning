@echo off
chcp 65001
rem $tname="JEBI" 傳入給 main.jq
jq -c -r -s --arg tname JEBI -f main.jq direction.json typhoon0930.json beaufort_wind.json