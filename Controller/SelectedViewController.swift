//
//  SelectedViewController.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/10/18.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit

class SelectedViewController: UIViewController {
    
    @IBOutlet weak var bacrGroundImage: UIImageView!

    var City_Arr: [String] = ["基隆市", "臺北市", "新北市", "桃園市", "新竹市", "新竹縣", "苗栗縣", "臺中市", "彰化縣", "南投縣", "雲林縣", "嘉義市", "嘉義縣", "臺南市", "高雄市", "屏東縣", "臺東縣", "花蓮縣", "宜蘭縣", "澎湖縣", "金門縣", "連江縣"]
    
    @IBOutlet weak var btnOK: UIButton!

    @IBOutlet weak var locationTextField: UITextField!
    let picker = UIPickerView()
    
    var citys: [String] = []
    var locations: [String] = []
    var sortLocations: [String] = []
    var cityKey = Citys()
    
    var zoneIndex: Int = 0
    var locationURL: String = ""
    
    var weekViewModel = WeekViewModel()
    
    override func viewDidLoad() {
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.231372549, blue: 0.3411764706, alpha: 1)
        
        super.viewDidLoad()
        self.bacrGroundImage.alpha = 0.5
        self.bacrGroundImage.image = UIImage(named: "content_back")
        self.bacrGroundImage.contentMode = .scaleAspectFill
        
        picker.delegate = self
        picker.dataSource = self
        locationTextField.inputView = picker
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)

        locationTextField.layer.borderWidth = 1.5
        locationTextField.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        locationTextField.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view.
        
    }
    
    ///關閉鍵盤
    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }
    

    @IBAction func btnOK_Click(_ sender: Any) {
        
        closeKeyboard()
        var indexLocationURL: String = ""
        indexLocationURL = locationURL
        
        
//        let indexNav = self.tabBarController?.viewControllers?.first as! UINavigationController
//        let index = indexNav.viewControllers.first as! IndexViewController
        
        let indexTab = self.tabBarController?.viewControllers?[0] as! IndexViewController

        
        if locationTextField.text?.isEmpty == false {
            indexTab.zoneIndex = zoneIndex
            indexTab.locationURL = indexLocationURL

            let alertController = UIAlertController(title: "城市設定完成", message: "您設定的城市區域為\(locationTextField.text ?? "")", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default)
            {
                (Void) in
                
//                // 呈現主視圖 setCitys IndexVC
//                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "indexSwitch") {
//                    UIApplication.shared.keyWindow?.rootViewController = viewController
//
//
//                    self.dismiss(animated: true, completion: nil)
//                }
            }
            alertController.addAction(OKAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func pickerViewSetup() {
        
        weekViewModel.getWeekListData(citykey: cityKey.taiwan)
        weekViewModel.reloadWeekList = { [weak self] ()  in
            ///UI chnages in main tread
            DispatchQueue.main.async {
                
                for location in (self?.weekViewModel.arrayOfList[0].location)! {
                    //print(location.locationName)
                
                    self?.citys.append(location.locationName)
                }
                
                self!.picker.reloadAllComponents()
                //print(self!.locations.count)
            }
        }
    }
}

extension SelectedViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            //return citys.count
            return City_Arr.count
        case 1:
            return locations.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
        case 0:
            //return citys[row]
            return City_Arr[row]
        case 1:
            return locations[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let cityText: String = City_Arr[picker.selectedRow(inComponent: 0)]
        var locationText: String = ""
        switch component {
            case 0:
                setlocations(city: City_Arr[row])
                
                //locationURL = City_Arr[row]
                locationTextField.text = City_Arr[row]
                picker.reloadAllComponents()
                picker.selectRow(0, inComponent: 1, animated: true)
            case 1:
                locationText = locations[picker.selectedRow(inComponent: 1)]
                picker.reloadAllComponents()
                zoneIndex = row
            default:
                locationTextField.text = City_Arr[row]
        }
        
        locationTextField.text = "\(cityText + locationText)"

    }
    
    func setlocations(city: String) {
        //var locationURL: String = ""
        
//        let indexNav = self.tabBarController?.viewControllers?.first as! UINavigationController
//        let indexTab = indexNav.viewControllers.first as! IndexViewController
        //let indexTab = self.tabBarController?.viewControllers?[0] as! IndexViewController
        
        switch city {
            case "雲林縣":
                locationURL = cityKey.yunlin
                //indexTab.locationURL = locationURL
                break
            case "南投縣":
                locationURL = cityKey.nantou
                //indexTab.locationURL = locationURL
                break
            case "連江縣":
                locationURL = cityKey.lienchiang
                //indexTab.locationURL = locationURL
                break
            case "臺東縣":
                locationURL = cityKey.taitung
                //indexTab.locationURL = locationURL
                break
            case "金門縣":
                locationURL = cityKey.kinmem
                //indexTab.locationURL = locationURL
                break
            case "宜蘭縣":
                locationURL = cityKey.yilan
                //indexTab.locationURL = locationURL
                break
            case "屏東縣":
                locationURL = cityKey.pingtung
                //indexTab.locationURL = locationURL
                break
            case "苗栗縣":
                locationURL = cityKey.miaoli
                //indexTab.locationURL = locationURL
                break
            case "澎湖縣":
                locationURL = cityKey.penghu
                //indexTab.locationURL = locationURL
                break
            case "臺北市":
                locationURL = cityKey.taipei
                //indexTab.locationURL = locationURL
                break
            case "新竹縣":
                locationURL = cityKey.hsinchushin
                //indexTab.locationURL = locationURL
                break
            case "花蓮縣":
                locationURL = cityKey.hualien
                //indexTab.locationURL = locationURL
                break
            case "高雄市":
                locationURL = cityKey.kaohsiung
                //indexTab.locationURL = locationURL
                break
            case "彰化縣":
                locationURL = cityKey.changhua
                //indexTab.locationURL = locationURL
                break
            case "新竹市":
                locationURL = cityKey.hsinchu
                //indexTab.locationURL = locationURL
                break
            case "新北市":
                locationURL = cityKey.newTaipei
                //indexTab.locationURL = locationURL
                break
            case "基隆市":
                locationURL = cityKey.keeling
                //indexTab.locationURL = locationURL
                break
            case "臺中市":
                locationURL = cityKey.taichung
                //indexTab.locationURL = locationURL
                break
            case "臺南市":
                locationURL = cityKey.tainan
                //indexTab.locationURL = locationURL
                break
            case "桃園市":
                locationURL = cityKey.taoyung
                //indexTab.locationURL = locationURL
                break
            case "嘉義縣":
                locationURL = cityKey.chiayishin
                //indexTab.locationURL = locationURL
                break
            case "嘉義市":
                locationURL = cityKey.chiayi
                //indexTab.locationURL = locationURL
                break
            default:
                locationURL = cityKey.taipei
                //indexTab.locationURL = locationURL
        }
        
        self.locations.removeAll()
        
     
        weekViewModel.getWeekListData(citykey: locationURL)
        weekViewModel.reloadWeekList = { [weak self] ()  in
            ///UI chnages in main tread
            DispatchQueue.main.async {
                
                for location in (self?.weekViewModel.arrayOfList[0].location)! {
                    //print(location.locationName)
                    self?.locations.append(location.locationName)
                }
              
                self!.picker.reloadAllComponents()
                //print(self!.locations.count)
            }
        }
    }
}

