@echo off
chcp 65001

jq -c -r -s ".[0] as $direction | .[1] as $ty |[\"時間     \",\"經度\",\"緯度\",\"氣壓\",\"風速MAX\",\"陣風MAX\",\"方向 \",\"預測\"],[$ty.records.tropicalCyclones.tropicalCyclone[] | select(.typhoonName==\"KRATHON\") | .analysisData.fix[-5:][] | [.fixTime[0:13], (.coordinate|split(\",\")[0]), (.coordinate|split(\",\")[1]), .pressure, .maxWindSpeed, .maxGustSpeed, $direction[.movingDirection], .movingPrediction[0].value]][] | @tsv" direction.json typhoon1005.json