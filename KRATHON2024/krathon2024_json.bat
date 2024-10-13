@echo off
chcp 65001
rem $tname="KRATHON" 傳入給 main.jq
jq -c -r -s --arg tname KRATHON -f main.jq direction.json typhoon1005.json beaufort_wind.json