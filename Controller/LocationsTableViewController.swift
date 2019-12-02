//
//  LocationsTableViewController.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/11/6.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController {
    
    @IBOutlet weak var backImageView: UIImageView!
    let service = WeatherService()
    
    let urlStr = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=rdec-key-123-45678-011121314"
    
    var locationURL: String = ""
    var cityKey = Citys()

    var tableviewcolor = UIView()
    
    @IBOutlet var locationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getWeather(fromService: service)
        
        //tableviewcolor.backgroundColor = .none
        
        self.locationTableView.delegate = self
        self.locationTableView.dataSource = self
        //tableview cell border
        self.locationTableView.separatorStyle = .none

        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.231372549, blue: 0.3411764706, alpha: 1)
        
        //self.locationTableView.backgroundColor = #colorLiteral(red: 0, green: 0.231372549, blue: 0.3411764706, alpha: 1)
    }
    
    private func getWeather<S: Gettable>(fromService service: S) where S.T == Array<Weather?> {
        
        service.get { [weak self] (result) in
            switch result {
            case .Success(let weathers):
                var tempWeather = [Weather]()
                
                for weather in weathers {
                    if let weather = weather {
                                
                        tempWeather.append(weather)
                    }
                }
                
                for var i in 0...21 {
                      i -= 1
                      tempWeather.forEach { list in
                        let Num: Int = (self?.sort(locationName: list.title))!
                        if Num == self!.weatherArray.count {
                            self!.weatherArray.append(list)
                              i += 1
                          }
                      }
                }

            //dump(self.movies)
            case .Error(let error):
                print(error)
            }
        }
    }
    
    private var weatherArray = [Weather]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  weatherArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableviewcell = tableView.dequeueReusableCell(withIdentifier: "locationTableViewCell", for: indexPath) as! locationTableViewCell
        tableviewcell.backgroundColor = #colorLiteral(red: 0, green: 0.231372549, blue: 0.3411764706, alpha: 1)

        let weather = weatherArray[indexPath.row]
        
        let weatherViewModel = WeatherViewModel(model: weather)
        tableviewcell.displayWeatherInCell(using: weatherViewModel)
        tableviewcell.selectedBackgroundView = tableviewcolor
        
        return tableviewcell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    var locationName: String = ""
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        let locationSelectedVC: LocationSelectedViewController = self.storyboard?.instantiateViewController(withIdentifier: "locationSelectedVC") as! LocationSelectedViewController
        
        self.locationName = weatherArray[indexPath.row].title
        
        locationSelectedVC.locationURL = locationName
        
        present(locationSelectedVC, animated: true, completion: nil)
        
    }
    

    func sort(locationName: String) -> Int {
        var cityNum: Int = 0
        
        switch locationName {
        case "基隆市":
            cityNum = 0
        case "臺北市":
            cityNum = 1
        case "新北市":
            cityNum = 2
        case "桃園市":
            cityNum = 3
        case "新竹市":
            cityNum = 4
        case "新竹縣":
            cityNum = 5
        case "苗栗縣":
            cityNum = 6
        case "臺中市":
            cityNum = 7
        case "彰化縣":
            cityNum = 8
        case "南投縣":
            cityNum = 9
        case "雲林縣":
            cityNum = 10
        case "嘉義市":
            cityNum = 11
        case "嘉義縣":
            cityNum = 12
        case "臺南市":
            cityNum = 13
        case "高雄市":
            cityNum = 14
        case "屏東縣":
            cityNum = 15
        case "臺東縣":
            cityNum = 16
        case "花蓮縣":
            cityNum = 17
        case "宜蘭縣":
            cityNum = 18
        case "澎湖縣":
            cityNum = 19
        case "金門縣":
            cityNum = 20
        case "連江縣":
            cityNum = 21
        default:
            cityNum = 22
        }
        
        return cityNum
    }
    
}
