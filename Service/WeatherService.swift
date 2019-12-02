//
//  WeatherService.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/9/29.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import Foundation
import UIKit

//2 conform to protocol
struct WeatherService: Gettable {
    
    //3
    //let endpoint: String = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
    let endpoint: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=rdec-key-123-45678-011121314"

    let downloader = JSONDownloader()
    
    //the associated type is inferred by <[Movie?]>
    typealias CurrentWeatherCompletionHandler = (Results<[Weather?]>) -> ()
    
    //4 protocol required function
    func get(completion: @escaping CurrentWeatherCompletionHandler) {
        
        guard let url = URL(string: self.endpoint) else {
            completion(.Error(.invalidURL))
            return
        }
        //5 using the JSONDownloader function
        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Error(let error):
                    completion(.Error(error))
                    return
                case .Success(let json):
                    //6 parsing the Json response
                    guard let weatherJSONrecords = json["records"] as? [String: AnyObject], let weatherJSONlocation = weatherJSONrecords["location"] as? [[String: AnyObject]] else {
                        completion(.Error(.jsonParsingFailure))
                        return
                    }

                    //print(weatherJSONlocation)

                    //7 maping the array and create Movie objects
                    let weatherArray = weatherJSONlocation.map{Weather(json: $0)}
                    
                    //print(weatherArray)
                    completion(.Success(weatherArray))
                
                }
            }
        }
        task.resume()
    }
}

//1 uisng associatedType in protocol
protocol Gettable {
    associatedtype T
    func get(completion: @escaping (Results<T>) -> Void)
}
