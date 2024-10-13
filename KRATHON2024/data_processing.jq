# 處理透過 slurp 讀進來的陣列，回傳物件
def process_input:
  #debug(type, keys) |
  if (type=="array" and length==3) then 
    {
      direction: .[0], # 來自 direction.json
      typhoon: .[1],   # 來自 typhoon1005.json
      beaufort: .[2]   # 來自 beaufort_wind.json
    }
  else
    error("Expected array length of 3, but got \(type) " + (length | tostring))  
  end;

# 輸出固定標題，回傳字串陣列
def header:
  ["時間     ","經度","緯度","氣壓","風速MAX   ","陣風MAX   ","方向 ","預測"];

# 以逗號(,)拆開輸入字串，回傳陣列
def separate(f): f|split(","); 

# 轉換輸入的風速(m/s)字串，回傳對應的蒲伏風級
def beaufort(f; wind_array):
  (f|tonumber) as $speed |
  wind_array[] |
  select($speed>=.min and $speed<.max)|
  .level;  

# 主要的資料內容，回傳颱風路徑陣列
def content(s):
  if ((s|type)=="string") then 
    .beaufort as $wind | 
    .direction as $direction |
    .typhoon.records.tropicalCyclones.tropicalCyclone[] | 
    select(.typhoonName==s) | 
    .analysisData.fix[-5:][] |
    [
      .fixTime[0:13], 
      separate(.coordinate)[0], 
      separate(.coordinate)[1], 
      .pressure, 
      beaufort(.maxWindSpeed; $wind),
      beaufort(.maxGustSpeed; $wind),
      $direction[.movingDirection] // .movingDirection, 
      .movingPrediction[0].value
    ]
  else
    error("Expected type string, but got  " + (s | type))  
  end;    

def content:
  content("KRATHON");
  