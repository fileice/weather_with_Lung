//
//  FirstViewController.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/11/29.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    var timer = Timer()
    
    var nowVersion = ""
    let thisVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    var versionSession = URLSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // Do any additional setup after loading the view.
        getVersion()
        NotificationCenter.default.addObserver(self, selector: #selector(FirstViewController.checkStatus), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkStatus()

    }
    
    @objc func checkStatus() {
        getVersion()
        
        if !CheckInterNetConnrction.isConnectedToNetwork() {
            let alertController = UIAlertController(title: "請開啟網路連線或使用Wifi連線", message: nil, preferredStyle: .alert)
            let close = UIAlertAction(title: "關閉", style: .default, handler: nil)
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
            
            alertController.addAction(close)
            alertController.addAction(setting)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            if thisVersion != nowVersion {
               // print("2:\(nowVersion)----\(thisVersion)")
                let alertController = UIAlertController(title: "訊息", message: "您的看看天氣並未更新到最新版，請更新至最新版本", preferredStyle: .alert)
                
                let updateAction = UIAlertAction(title: "確認", style: .default) { (action) in
                    
                    UIApplication.shared.canOpenURL(URL(string: "https://apps.apple.com/tw/app/%E7%9C%8B%E7%9C%8B%E5%A4%A9%E6%B0%A3/id1488575551")!)
                }
                
                alertController.addAction(updateAction)
                if let vc = UIApplication.shared.keyWindow?.rootViewController {
                    vc.present(alertController, animated: true, completion: nil)
                }
                
            } else {
                self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(FirstViewController.disMiss), userInfo: nil, repeats: true)
            }
        }
    }
    
    ///呈現主視圖
    @objc func disMiss() {
        timer.invalidate()

        // 呈現主視圖
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "mainTabbar") {
            UIApplication.shared.keyWindow?.rootViewController = viewController

            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer.invalidate()
    }
    
    ///get vision
    @objc func getVersion(){
        let urlStr = "https://itunes.apple.com/lookup?bundleId=www.fileice.com.weather-with-Lung"
        let url = URL(string: urlStr)
        var request: URLRequest = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        let config = URLSessionConfiguration.default
        versionSession = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        _ = versionSession.downloadTask(with: request).resume()
        
    }
    
    ///checkVersion
    @objc func checkVersion() {
        if thisVersion != nowVersion {
            let alertController = UIAlertController(title: "訊息", message: "您的看看天氣並未更新到最新版，請更新至最新版本", preferredStyle: .alert)
            
            let updateAction = UIAlertAction(title: "確認", style: .default) { (action) in
                
                UIApplication.shared.canOpenURL(URL(string: "https://apps.apple.com/tw/app/%E7%9C%8B%E7%9C%8B%E5%A4%A9%E6%B0%A3/id1488575551")!)
            }
            
            alertController.addAction(updateAction)
            if let vc = UIApplication.shared.keyWindow?.rootViewController {
                vc.present(alertController, animated: true, completion: nil)
            }
        }
    }

}

extension FirstViewController: URLSessionDelegate, URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //let postData = NSData(contentsOf: location)
        //print(String(data: postData! as Data, encoding: .utf8)!)
        
        do {
            DispatchQueue.main.async {
                //do something here
            }
            
            if session == versionSession {
                let array = try JSONSerialization.jsonObject(with: Data(contentsOf: location), options: .mutableContainers) as! NSDictionary
                
                let dataArray = array.object(forKey: "results") as! NSArray
                let data = dataArray[0] as! NSDictionary
                nowVersion = "\(String(describing: data.object(forKey: "version")!))"
                print(nowVersion)
                checkVersion()
            }
        } catch {
            //do something
        }
        session.finishTasksAndInvalidate()
        
    }
}
