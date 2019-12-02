//
//  WeatherViewModel.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/10/2.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import Foundation
import UIKit

struct WeatherViewModel {
    let title: String
    let date: String
    let comfort: String
    let parameter: String
    let temperature: String
    let weatherCI: String
    
    init(model: Weather) {
        self.title = model.title
        self.date = model.date
        self.comfort = model.comfort
        self.parameter = model.parameter
        self.temperature = model.temperature
        self.weatherCI = model.weatherCI
    }
}

