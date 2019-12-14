//
//  ObservationViewController.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/12/7.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit

class ObservationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var observationTableView: UITableView!
    
    
    let imageAddress = "https://www.cwb.gov.tw/Data/radar/CV1_TW_1000_forPreview.png"

    let hasImageArray = ["雷達回波","衛星雲圖","累積雨量圖","溫度分布圖","紫外線測報","即時閃電"]
    let hasIamgeArrayImageURL = [
        //雷達
        "https://www.cwb.gov.tw/Data/radar/CV1_TW_1000_forPreview.png",
        //衛星
        "https://www.cwb.gov.tw/Data/satellite/LCC_VIS_TRGB_1000/LCC_VIS_TRGB_1000_forPreview.jpg",
        //雨量
        "https://www.cwb.gov.tw/Data/rainfall/QZJ_forPreview.jpg",
        //溫度
        "https://www.cwb.gov.tw/Data/temperature/temp_forPreview.jpg",
        //紫外線
        "https://www.cwb.gov.tw/Data/UVI/UVI_forPreview.png",
        //即時閃電
        "https://www.cwb.gov.tw/Data/lightning/lightning_s_forPreview.jpg"
    ]
    
    let noImageArray = ["今日排行榜","前100大雨量","縣市最大雨量","前100名溫度資料","縣市溫度極值資"]
    
    let hasImageLinkURLArray = [
        "https://www.cwb.gov.tw/V8/C/W/OBS_Radar.html",
        "https://www.cwb.gov.tw/V8/C/W/OBS_Sat.html",
        "https://www.cwb.gov.tw/V8/C/P/Rainfall/Rainfall_QZJ.html",
        "https://www.cwb.gov.tw/V8/C/W/OBS_Temp.html",
        "https://www.cwb.gov.tw/V8/C/W/OBS_UVI.html",
        "https://www.cwb.gov.tw/V8/C/W/OBS_Lightning.html"
    ]
    
    let noImageLinkURLArray = [
        "https://www.cwb.gov.tw/V8/C/W/OBS_Top.html",
        "https://www.cwb.gov.tw/V8/C/P/Rainfall/Rainfall_Top100.html",
        "https://www.cwb.gov.tw/V8/C/P/Rainfall/Rainfall_CountyMax.html",
        "https://www.cwb.gov.tw/V8/C/W/OBS_Top100.html",
        "https://www.cwb.gov.tw/V8/C/W/County_TempTop.html"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getImageFromCWB(imageAddress: imageAddress)
        self.observationTableView.delegate = self
        self.observationTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    ///取得image
    func getImageFromCWB(imageAddress: String) {
        if let imageURL = URL(string: imageAddress) {
            DispatchQueue.global().async {
                do {
                    //
                    let imageData = try Data(contentsOf: imageURL)
                    let downLoadImage = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        //self.observImageView.image = downLoadImage
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return hasImageArray.count
        } else if section == 1 {
            return noImageArray.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "HasImageCell", for: indexPath) as! HasImageTableViewCell
            
            //print(hasIamgeArrayImageURL[indexPath.row])
            
            if let imageURL = URL(string: hasIamgeArrayImageURL[indexPath.row]) {
                DispatchQueue.global().async {
                    do {
                        //
                        let imageData = try Data(contentsOf: imageURL)
                        let downLoadImage = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            //self.observImageView.image = downLoadImage
                            cell.weatherImageView.image = downLoadImage
                            //cell.weatherImageView.translatesAutoresizingMaskIntoConstraints = false
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            cell.titleLabel.text = hasImageArray[indexPath.row]
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoImageCell", for: indexPath) as! NoImageTableViewCell
            
            cell.titleLabel.text = noImageArray[indexPath.row]
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    //set cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 300
        } else {
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let webViewVC: WebViewController = self.storyboard?.instantiateViewController(withIdentifier: "webviewVC") as! WebViewController
            webViewVC.linkURL = hasImageLinkURLArray[indexPath.row]
            
            self.navigationController?.show(webViewVC, sender: nil)
        } else if indexPath.section == 1 {
            let webViewVC: WebViewController = self.storyboard?.instantiateViewController(withIdentifier: "webviewVC") as! WebViewController
            webViewVC.linkURL = noImageLinkURLArray[indexPath.row]
                
            self.navigationController?.show(webViewVC, sender: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
}
