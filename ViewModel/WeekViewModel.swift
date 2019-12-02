//
//  WeekViewModel.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/10/16.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit

class WeekViewModel {
    
    let cityKey = Citys()
    
    ///clouser use for notifi
    var reloadWeekList = {() -> () in }
    var errorMessage = { (message: String) -> () in}
    
    ///Array of List Model class
    var arrayOfList : [locations] = []{
        ///Reload data when data set
        didSet{
            reloadWeekList()
        }
    }
    
   ///get data from webApi
   func getWeekListData() {
    
        guard let listURL = URL(string: cityKey.kaohsiung)else {
           return
       }
       
       URLSession.shared.dataTask(with: listURL) { (data, response, error) in
           guard let jsonData = data else { return }
           do {
               ///Using Decodeable data parse
               let decoder = JSONDecoder()
              
               let locationArray = try decoder.decode(Week.self, from: jsonData)
               self.arrayOfList = locationArray.records.locations
               //print(self.arrayOfList)
               //self.arrayOfLocationslist = locationArray.records.locations[0].location

           } catch let error {
               print("Error -> \(error.localizedDescription)")
               self.errorMessage(error.localizedDescription)
           }
       }.resume()
   }
    
    ///get data from webApi
    func getWeekListData(citykey: String) {
        
        guard let listURL = URL(string: citykey)else {
            return
        }
        
        URLSession.shared.dataTask(with: listURL) { (data, response, error) in
            guard let jsonData = data else { return }
            do {
                ///Using Decodeable data parse
                let decoder = JSONDecoder()
               
                let locationArray = try decoder.decode(Week.self, from: jsonData)
                self.arrayOfList = locationArray.records.locations
                //self.arrayOfLocationslist = locationArray.records.locations[0].location

            } catch let error {
                print("Error -> \(error.localizedDescription)")
                self.errorMessage(error.localizedDescription)
            }
        }.resume()
    }
    
}
