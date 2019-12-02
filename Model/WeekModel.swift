//
//  WeekModel.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/10/16.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit

class Week: Codable {
    var success: String
    var result: result
    var records: records
}

class result: Codable {
    var resource_id: String
    
}

class records: Codable {
    var locations: [locations]
}

class locations: Codable {
    var datasetDescription: String
    var locationsName: String
    var location: [location]
}

class location: Codable {
    var locationName: String
    var geocode: String
    var lat: String
    var lon: String
    var weatherElement: [weatherElement]
}

class weatherElement: Codable {
    var elementName: String
    var description: String
    var time: [time]
}

class time: Codable {
    var startTime: String
    var endTime: String
    var elementValue: [elementValue]
    
}

class elementValue: Codable {
    var value: String
    var measures: String
}
