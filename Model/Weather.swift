//
//  Weather.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/10/2.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import Foundation
import UIKit

struct Weather {
    
    let title: String
    let date: String
    let comfort: String
    let temperature: String
    let parameter: String
    let weatherCI: String
}

extension Weather {
    
    struct Key  {
    
        static let title = "locationName"
        static let elementName = "elementName"
        static let startTime = "startTime"
        static let endTime = "endTime"
        static let parameter = "parameter"
        static let parameterValue = "parameterValue"
        static let parameterName = "parameterName"
        static let elementNameWx = "elementNameWx"
    }
    
    
    //failable initializer
    init?(json: [String: AnyObject]) {
        
        //print(json["weatherElement"] as! Array<Any>)
        
        let weatherArray1 = json["weatherElement"] as? [[String: AnyObject]]
        //print(weatherArray1)
        
        let elementArray1 = weatherArray1![0] //as? [String: AnyObject]

        //print(elementArray1
        
        let timeArray1 = elementArray1["time"] as? Array<AnyObject>
        //print(timeArray1)
        
        let starttime = timeArray1?[0] as? [String: AnyObject]
        
        //print(parameterName2["parameterName"])
        //print(starttime?["parameter"])
        
        _ = starttime?["parameter"] as! [String: AnyObject]
        //print(parameterName1["parameterName"])
        
//        let elementArray3 = weatherArray1![3] as? [String: AnyObject]
//        let timeArray3 = elementArray3!["time"] as? Array<AnyObject>
//        let comArray = timeArray3?[0] as? [String: AnyObject]
//        let parameterName3 = comArray?["parameter"] as! [String: AnyObject]
//        print(parameterName3)
        
        guard let title = json[Key.title] as? String,
            let weatherArray = json["weatherElement"] as? [[String: AnyObject]],
            let elementArray = weatherArray[0] as? [String: AnyObject],
            let timeArray = elementArray["time"] as? Array<Any>,
            let parameterArray = timeArray[0] as? [String: AnyObject],
            let startTime = parameterArray["startTime"] as? String,
            let parameterNameArray = parameterArray["parameter"] as? [String: AnyObject],
            let parameterName = parameterNameArray["parameterName"] as? String,
            
            let elementArrayMinT = weatherArray[2] as? [String: AnyObject],
            let timeArrayMinT = elementArrayMinT["time"] as? Array<AnyObject>,
            let tempArrayMinT = timeArrayMinT[0] as? [String: AnyObject],
            let parameterNameArrayMinT = tempArrayMinT["parameter"] as? [String: AnyObject],
            let parameterNameMinT = parameterNameArrayMinT["parameterName"] as? String,
            
            let elementArrayMaxT = weatherArray[4] as? [String: AnyObject],
            let timeArrayMaxT = elementArrayMaxT["time"] as? Array<AnyObject>,
            let tempArrayMaxT = timeArrayMaxT[0] as? [String: AnyObject],
            let parameterNameArrayMaxT = tempArrayMaxT["parameter"] as? [String: AnyObject],
            let parameterNameMaxT = parameterNameArrayMaxT["parameterName"] as? String,
            
            let elementArrayCloudy = weatherArray[3] as? [String: AnyObject],
            let timeArrayCloudy = elementArrayCloudy["time"] as? Array<AnyObject>,
            let cloudyArray = timeArrayCloudy[0] as? [String: AnyObject],
            let parameterNameArrayCloudy = cloudyArray["parameter"] as? [String: AnyObject],
            let parameterNameCloudy = parameterNameArrayCloudy["parameterName"] as? String,
        
            let elementArrayComfort = weatherArray[1] as? [String: AnyObject],
            let timeArrayComfort = elementArrayComfort["time"] as? Array<AnyObject>,
            let comfortArray = timeArrayComfort[0] as? [String: AnyObject],
            let parameterNameArrayComfort = comfortArray["parameter"] as? [String: AnyObject],
            let parameterNameComfort = parameterNameArrayComfort["parameterName"] as? String
            
            else {
                return nil
        }
                
        self.title = title
        self.date = startTime
        self.parameter = "\(parameterName)" + "," + "\(parameterNameCloudy)"
        self.comfort = "舒適度：\(parameterNameComfort)%"
        self.temperature = "\(parameterNameMinT)℃" + "~" + "\(parameterNameMaxT)℃"
        self.weatherCI = parameterName
    }
 
}

