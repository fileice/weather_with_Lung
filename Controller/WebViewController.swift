//
//  WebViewController.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/12/2.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

class WebViewController: UIViewController,WKNavigationDelegate, WKUIDelegate {
    
    var linkURL: String = ""
    @IBOutlet var weatherWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //hide tabbar
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    
        weatherWebView = WKWebView(frame: UIScreen.main.bounds)
        
        weatherWebView.navigationDelegate = self
        weatherWebView.uiDelegate = self
        
        let weatherURL = URL(string: linkURL)!
        
        let weatherRequest = URLRequest(url: weatherURL)
        
        weatherWebView.load(weatherRequest)
        
        view.addSubview(weatherWebView)
        // Do any additional setup after loading the view.
        
        
        //add button to reload wkwebview
        _ = self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reload))
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    webView.evaluateJavaScript("document.getElementById(\"header\").style.display='none';document.getElementById(\"footer-v3\").style.display='none';document.getElementById(\"normal\").getElementsByClassName(\"other\")[0].style.display='none';document.getElementById(\"normal\").getElementsByClassName(\"btn-blue\")[0].style.display='none';") { (result, error) in
        if error == nil {
            
            }
        }
        
    }
    
    @objc func reload() {
        self.weatherWebView.reload()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

