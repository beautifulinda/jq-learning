@echo off
chcp 65001

jq -c -r "[\"時間     \",\"經度\",\"緯度\",\"氣壓\",\"風速MAX\",\"陣風MAX\",\"方向 \",\"預測\"],[.records.tropicalCyclones.tropicalCyclone[] | select(.typhoonName==\"KRATHON\") | .analysisData.fix[-5:][] | [.fixTime[0:13], (.coordinate|split(\",\")[0]), (.coordinate|split(\",\")[1]), .pressure, .maxWindSpeed, .maxGustSpeed, (.movingDirection | if . == \"N\" then \"北 ↑\" elif . == \"S\" then \"南 ↓\" elif . == \"E\" then \"東 →\" elif . == \"W\" then \"西 ←\" else . end), .movingPrediction[0].value]][] | @tsv" typhoon0930.json