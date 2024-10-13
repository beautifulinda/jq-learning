# 期望參數 -c -r -s
# 期望輸入 direction.json typhoon1005.json beaufort_wind.json

include "data_processing"; process_input | header, [ content(1) ][] | @tsv 