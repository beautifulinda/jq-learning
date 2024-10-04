@echo off
chcp 65001

jq -c -r "{\"N\": \"北 ↑\", \"S\": \"南 ↓\", \"E\": \"東 →\", \"W\": \"西 ←\",  \"NE\": \"東北 ↗\", \"SE\": \"東南 ↘\", \"SW\": \"西南 ↙\", \"NW\": \"西北 ↖\"} as $direction|[\"時間     \",\"經度\",\"緯度\",\"氣壓\",\"風速MAX\",\"陣風MAX\",\"方向 \",\"預測\"],[.records.tropicalCyclones.tropicalCyclone[] | select(.typhoonName==\"KRATHON\") | .analysisData.fix[-5:][] | [.fixTime[0:13], (.coordinate|split(\",\")[0]), (.coordinate|split(\",\")[1]), .pressure, .maxWindSpeed, .maxGustSpeed, $direction[.movingDirection], .movingPrediction[0].value]][] | @tsv" typhoon0930.json