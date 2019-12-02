//
//  AppleViewModel.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/11/28.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit

class AppleViewModel {
        
    //https://itunes.apple.com/lookup?bundleId=www.fileice.com.weather-with-Lung
    
    ///clouser use for notifi
    var reloadAppleList = {() -> () in }
    var errorMessage = { (message: String) -> () in}
    
    ///Array of List Model class
    var arrayOfList : [results] = []{
        ///Reload data when data set
        didSet{
            reloadAppleList()
        }
    }
    
    ///get data from webApi
    func getAppleListData(apikey: String) {
        
        guard let listURL = URL(string: apikey)else {
            return
        }
        
        URLSession.shared.dataTask(with: listURL) { (data, response, error) in
            guard let jsonData = data else { return }
            do {
                ///Using Decodeable data parse
                let decoder = JSONDecoder()
               
                let appleArray = try decoder.decode(AppleAPIModel.self, from: jsonData)
                self.arrayOfList = appleArray.results

            } catch let error {
                print("Error -> \(error.localizedDescription)")
                self.errorMessage(error.localizedDescription)
            }
        }.resume()
    }
    
}
