//
//  WeatherViewURL.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/12/7.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import Foundation

///氣象局網址
class WeatherViewURL {
    
    ///雷達回波
    let OBS_Radar = "https://www.cwb.gov.tw/V8/C/W/OBS_Radar.html"
    
    ///衛星雲圖
    let OBS_Sat = "https://www.cwb.gov.tw/V8/C/W/OBS_Sat.html"
    
    ///日累積圖
    let Rainfall_QZJ = "https://www.cwb.gov.tw/V8/C/P/Rainfall/Rainfall_QZJ.html"
    
    ///小時累積圖
    let Rainfall_QZT = "https://www.cwb.gov.tw/V8/C/P/Rainfall/Rainfall_QZT.html"
    
    ///溫度分布圖
    let OBS_Temp = "https://www.cwb.gov.tw/V8/C/W/OBS_Temp.html"
    
    ///紫外線預報
    let MFC_UVI_Map = "https://www.cwb.gov.tw/V8/C/W/MFC_UVI_Map.html"
    
    ///即時閃電
    let OBS_Lightning = "https://www.cwb.gov.tw/V8/C/W/OBS_Lightning.html"
    
    ///天氣排行榜
    let OBS_Top = "https://www.cwb.gov.tw/V8/C/W/OBS_Top.html"
    
    ///前100名溫度資料
    let OBS_Top100 = "https://www.cwb.gov.tw/V8/C/W/OBS_Top100.html"
    
    ///縣市溫度極值
    let County_TempTop = "https://www.cwb.gov.tw/V8/C/W/County_TempTop.html"
}


class WeatherImageURL {
    ///雷達
    let radar = "https://www.cwb.gov.tw/Data/radar/CV1_TW_1000_forPreview.png"
    
    ///紫外線
    let UVI = "https://www.cwb.gov.tw/Data/UVI/UVI_forPreview.png"
    ///雨量
    let rainfall = "https://www.cwb.gov.tw/Data/rainfall/QZJ_forPreview.jpg"
    ///衛星
    let satellite = "https://www.cwb.gov.tw/Data/satellite/LCC_VIS_TRGB_1000/LCC_VIS_TRGB_1000_forPreview.jpg"
    ///即時閃電
    let lightning = "https://www.cwb.gov.tw/Data/lightning/lightning_s_forPreview.jpg"
    ///溫度
    let temperature = "https://www.cwb.gov.tw/Data/temperature/temp_forPreview.jpg"
}
