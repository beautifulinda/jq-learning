# 期望參數 -c -r -s
# 期望輸入 direction.json typhoon1005.json beaufort_wind.json
def separate(f): f|split(","); 
def beaufort(f; wind_array):
  (f|tonumber) as $speed |
  wind_array[] |
  select($speed>=.min and $speed<.max)|
  .level;
.[0] as $direction | .[1] as $ty | .[2] as $wind |
["時間     ","經度","緯度","氣壓","風速MAX   ","陣風MAX   ","方向 ","預測"],
[
  $ty.records.tropicalCyclones.tropicalCyclone[] | 
  select(.typhoonName=="KRATHON") | 
  .analysisData.fix[-5:][] |
  [
    .fixTime[0:13], 
    separate(.coordinate)[0], 
    separate(.coordinate)[1], 
    .pressure, 
    beaufort(.maxWindSpeed; $wind),
    beaufort(.maxGustSpeed; $wind),
    $direction[.movingDirection], 
    .movingPrediction[0].value
  ]
][] | 
@tsv