//
//  IndexViewController.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/10/9.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController {
        
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblLocations: UILabel!
    @IBOutlet weak var lblElemenyValue: UILabel!
    @IBOutlet weak var lblBodyTemp: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var tempImage: UIImageView!
    
    @IBOutlet weak var bacrGroundImage: UIImageView!
    
    @IBOutlet weak var weekCollectionView: UICollectionView!
    
    let fullScreenSize = UIScreen.main.bounds.size
    
    var locationName: String = ""
    var maxTemp: String = ""
    var minTemp: String = ""
    var avgTemp: String = ""
    var bodyTemp: String = ""
    
    var locationURL: String = ""
    var zoneIndex: Int = 0
    
    var nowVersion = ""
    let thisVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    var versionSession = URLSession()
    
    var cityKey = Citys()
    
    var weekNum: [String] = []
    var tempMin: [String] = []
    var tempMax: [String] = []
    var elementValue: [String] = []
    var weatherImage: [String] = ["city_weather_icon_cloud_24px","city_weather_icon_cloud_rain_24px","city_weather_icon_cloudy_24px","city_weather_icon_cloudy_sun_24px","city_weather_icon_lightning_rain_24px","city_weather_icon_mist_sun_24px","city_weather_icon_rain_24px"]
    
    ///viewModel object
    var weekViewModel = WeekViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("viewDidLoad")
        //pageSetup()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //print("viewWillAppear")

        pageSetup()
        //chackVision()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if !CheckInterNetConnrction.isConnectedToNetwork() {
            
            showNoNetworkAlertDia()
        } else {
            getVersion()
        }
    }
    
    //偵測網路連線
    fileprivate func showNoNetworkAlertDia() {
        let alert: UIAlertController = UIAlertController(title: "請開啟網路連線或使用Wifi連線", message: nil, preferredStyle: .alert)
        let colose = UIAlertAction(title: "關閉", style: .default, handler: nil)
        let setting: UIAlertAction = UIAlertAction(title: "設定", style: .default, handler:{
            action in
            // 跳至網路設定
            let network = URL(string: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(network!) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(network!)
                } else {
                    UIApplication.shared.openURL(network!)
                }
            }
        })
        alert.addAction(colose)
        alert.addAction(setting)
        self.present(alert, animated: true, completion: nil)
    }
    
    //get vision
    @objc func getVersion(){
        let urlStr = "https://itunes.apple.com/lookup?bundleId=www.fileice.com.weather-with-Lung"
        let url = URL(string: urlStr)
        var request: URLRequest = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        let config = URLSessionConfiguration.default
        versionSession = URLSession(configuration: config, delegate: self as? URLSessionDelegate, delegateQueue: OperationQueue.main)
        _ = versionSession.downloadTask(with: request).resume()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        weekNum = []
        tempMax = []
        tempMin = []
        elementValue = []
        weatherImage = ["city_weather_icon_cloud_24px","city_weather_icon_cloud_rain_24px","city_weather_icon_cloudy_24px","city_weather_icon_cloudy_sun_24px","city_weather_icon_lightning_rain_24px","city_weather_icon_mist_sun_24px","city_weather_icon_rain_24px"]
    }
    
    ///model object
    var appleViewModel = AppleViewModel()
    var apiVision: String = ""
    
    let appleAPI = "https://itunes.apple.com/lookup?bundleId=www.fileice.com.weather-with-Lung"
    
    ///init check vision
//    func chackVision() {
//        appleViewModel.getAppleListData(apikey: appleAPI)
//
//        appleViewModel.reloadAppleList = { [weak self] () in
//
//            DispatchQueue.main.async {
//                self?.apiVision = self?.appleViewModel.arrayOfList[0].version ?? ""
//                print(self?.apiVision)
//            }
//        }
//    }
    
    
    
    ///initial page setting
    func pageSetup() {
        
        self.bacrGroundImage.alpha = 0.5
        self.bacrGroundImage.contentMode = .scaleAspectFill
        
        //navigationController 設定
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0, green: 0.231372549, blue: 0.3411764706, alpha: 1)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.231372549, blue: 0.3411764706, alpha: 1)

        //tabBarController 設定
        tabBarController?.tabBar.barTintColor = #colorLiteral(red: 0, green: 0.231372549, blue: 0.3411764706, alpha: 1)
        
        collectionViewSteup()
        
//        print(locationURL)
//        print(zoneIndex)
        
        if(locationURL == "") {
            weekViewModel.getWeekListData(citykey: cityKey.taipei)
        } else {
            weekViewModel.getWeekListData(citykey: locationURL)
        }

   
        //weekViewModel.getWeekListData()
        
        weekViewModel.reloadWeekList = { [weak self] ()  in
            ///UI chnages in main tread
            DispatchQueue.main.async {
                //print(self!.weekViewModel.arrayOfLocationslist)
                
                self?.locationName = (self?.weekViewModel.arrayOfList[0].locationsName)!
                self?.lblLocations.text = "\(self?.locationName ?? "")\(self!.weekViewModel.arrayOfList[0].location[self!.zoneIndex].locationName)"
            
                self?.avgTemp = (self?.weekViewModel.arrayOfList[0].location[self!.zoneIndex].weatherElement[12].time[0].elementValue[0].value)!
                self?.lblTemp.text = "\(self?.avgTemp ?? "")℃"
                
                self?.bodyTemp = (self?.weekViewModel.arrayOfList[0].location[self!.zoneIndex].weatherElement[5].time[0].elementValue[0].value)!
                
                self?.lblBodyTemp.text = "體感溫度\(self?.bodyTemp ?? "")℃"
                self?.lblElemenyValue.text = self?.weekViewModel.arrayOfList[0].location[self!.zoneIndex].weatherElement[6].time[0].elementValue[0].value
                
                let weatherIcon = self?.getImage(elementValue: self?.lblElemenyValue.text ?? "")
                
                self?.tempImage.image = UIImage(named: weatherIcon!)
                
                let currentDate = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "zh_Hant_TW")
                dateFormatter.timeZone = TimeZone(identifier: "Asia/Taipei")
                dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm"
                let dateTimeNow = dateFormatter.string(from: currentDate)
                //print(dateTimeNow)
                
//                dateFormatter.dateFormat = "EEE"
//                let weekDate = dateFormatter.string(from: currentDate)
//
//                dateFormatter.dateFormat = "HH:mm"
//                let timeNow = dateFormatter.string(from: currentDate)
                
                self?.lblDateTime.text = "\u{1F551}\(dateTimeNow)"
                
                for i in 0...6 {
                    self!.getDay(index: i)
                    self!.getWeatherElement(index: i, Temp: "MaxT") // MaxT（最高溫度）
                    self!.getWeatherElement(index: i, Temp: "MinT") // MinT（最低溫度）
                    self!.getWeatherElement(index: i, Temp: "elementValue") // MinT（最低溫度）
                }

                self?.weekCollectionView.reloadData()
            }
        }
    }
    
    func getImage(elementValue: String) -> String {
        switch elementValue {
        case "晴":
            bacrGroundImage.image = UIImage(named: "mainback_sun")
            return "city_weather_icon_sun"
        case "晴時多雲":
            bacrGroundImage.image = UIImage(named: "mainback_cloud")
            return "city_weather_icon_cloudy_sun"
        case "多雲":
            bacrGroundImage.image = UIImage(named: "mainback_cloudy")
            return "city_weather_icon_cloudy_sun"
        case "多雲時陰":
            bacrGroundImage.image = UIImage(named: "mainback_cloud")
            return "city_weather_icon_cloudy_sun"
        case "多雲短暫雨":
            bacrGroundImage.image = UIImage(named: "mainback_rain")
            return "city_weather_icon_rain"
        case "陰短暫雨":
            bacrGroundImage.image = UIImage(named: "mainback_rain")
            return "city_weather_icon_rain"
        case "多雲時晴":
            bacrGroundImage.image = UIImage(named: "mainback_cloud")
            return "city_weather_icon_cloudy_sun"
        case "陰天":
            bacrGroundImage.image = UIImage(named: "mainback_cloudy")
            return "city_weather_icon_cloud"
        default:
            bacrGroundImage.image = UIImage(named: "mainback_sun")
            return "city_weather_icon_sun"
        }
    }
}

extension IndexViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionViewSteup() {
        weekCollectionView.delegate = self
        weekCollectionView.dataSource = self
    }
    
    ///顯示七天
    func getDay(index: Int){
        let Day = Date()
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Day)
        var weekDay = dateComponents.weekday!
        let hour = dateComponents.hour!
        
        if hour >= 18{
            weekDay = weekDay + 1
        }
        weekDay = weekDay + index
        if weekDay > 7{
            weekDay = weekDay - 7
        }
        
        switch weekDay {
        case 1:
            weekNum.append("日")
            break;
        case 2:
            weekNum.append("一")
            break;
        case 3:
            weekNum.append("二")
            break;
        case 4:
            weekNum.append("三")
            break;
        case 5:
            weekNum.append("四")
            break;
        case 6:
            weekNum.append("五")
            break;
        case 7:
             weekNum.append("六")
             break;
        default:
            break;
        }
    }
    
    ///計算溫度
    func getWeatherElement(index: Int, Temp: String) {
        let Day = Date()
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Day)
        let hour = dateComponents.hour!
        
        var index = index * 2
        
        if hour >= 6 {
            index += 1
        }
        if hour >= 12 {
            index -= 1
        }
        
        if Temp == "MaxT" {
            var maxT: String = ""
            maxT = self.weekViewModel.arrayOfList[0].location[self.zoneIndex].weatherElement[12].time[index].elementValue[0].value
            tempMax.append(maxT + "º")
        } else if Temp == "MinT" {
            var minT: String = ""
            minT = self.weekViewModel.arrayOfList[0].location[self.zoneIndex].weatherElement[8].time[index].elementValue[0].value
            tempMin.append(minT + "º")
        } else if Temp == "elementValue" {
            var elementValues: String = ""
                       
            elementValues = self.weekViewModel.arrayOfList[0].location[self.zoneIndex].weatherElement[6].time[index].elementValue[0].value
            elementValue.append(elementValues)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekNum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekCell", for: indexPath) as! WeekCollectionCell
        
        let imageName = getImageIcon(elementValue: elementValue[indexPath.row])
        //print(elementValue[indexPath.row])
        cell.lblWeekDay.text = weekNum[indexPath.row]
        cell.imageTemp.image = UIImage(named: imageName)
        cell.lblMinTemp.text = tempMin[indexPath.row]
        cell.lblMaxTemp.text = tempMax[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: fullScreenSize.width/7 - 20 , height: fullScreenSize.height/2)
    }
    
    func getImageIcon(elementValue: String) -> String {
        
        var weatherText: String = ""
        
        if elementValue.contains("晴時多雲") {
            weatherText = "晴時多雲"
        }else if elementValue.contains("多雲時晴") {
            weatherText = "多雲時晴"
        }else if elementValue.contains("陰") && elementValue.contains("雨") {
            weatherText = "雨"
        }else if elementValue.contains("雨") {
            weatherText = "雨"
        }else if elementValue.contains("多雲") {
            weatherText = "多雲"
        }else if elementValue.contains("晴") {
            weatherText = "晴"
        }else if elementValue.contains("陰") {
            weatherText = "陰"
        }else if elementValue.contains("雷") {
            weatherText = "雷"
        }else if elementValue.contains("霧") {
            weatherText = "霧"
        }
        
        
        switch weatherText {
            case "晴":
                return "city_weather_icon_sun_24px"
            case "晴時多雲":
                return"city_weather_icon_cloudy_sun_24px"
            case "多雲":
                return "city_weather_icon_cloudy_24px"
            case "多雲時晴":
                return "city_weather_icon_cloudy_sun_24px"
            case "雨":
                return "city_weather_icon_rain_24px"
            case "陰":
                return "city_weather_icon_cloud_24px"
            case "雷":
                return "city_weather_icon_lightning_rain_24px"
            case "霧":
                return "city_weather_icon_mist_sun_24px"
            default:
                return "city_weather_icon_sun_24px"
        }
    }
}

