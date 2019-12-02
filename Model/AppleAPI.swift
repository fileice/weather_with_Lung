//
//  AppleAPI.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/11/28.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import Foundation

class AppleAPIModel: Codable {
    var resultCount: String
    var results: [results]
}

class results: Codable {
    var trackName: String
    var version: String
    var description: String
    var minimumOsVersion: String
    var bundleId: String
}
