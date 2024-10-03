@echo off
chcp 65001

rem set AUTHORIZATION=YOUR_AUTHORIZATION

curl -s https://opendata.cwa.gov.tw/api/v1/rest/datastore/W-C0034-005?Authorization=%AUTHORIZATION% | jq -c -r "[\"時間     \",\"經度\",\"緯度\",\"氣壓\",\"風速MAX\",\"陣風MAX\",\"方向 \",\"預測\"],[.records.tropicalCyclones.tropicalCyclone[] | select(.typhoonName==\"KRATHON\") | .analysisData.fix[-5:][] | [.fixTime[0:13], (.coordinate|split(\",\")[0]), (.coordinate|split(\",\")[1]), .pressure, .maxWindSpeed, .maxGustSpeed, (.movingDirection | if . == \"N\" then \"北 ↑\" elif . == \"S\" then \"南 ↓\" elif . == \"E\" then \"東 →\" elif . == \"W\" then \"西 ←\" else . end), .movingPrediction[0].value]][] | @tsv" 