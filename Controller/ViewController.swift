//
//  ViewController.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/9/27.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit

class CollectionViewController : UICollectionViewController {
    
    @IBOutlet var mycollectionview: UICollectionView!
    
    private var hiddenCells: [ExpandableCell] = []
    private var expandedCell: ExpandableCell?
    private var isStatusBarHidden = false
    
    let service = WeatherService()
    
    
    let urlStr = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=rdec-key-123-45678-011121314"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //downloadJson()
        getWeather(fromService: service)
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
    
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    private var weatherArray = [Weather]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - UICollectionViewDelegates
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectcell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExpandableCell", for: indexPath) as! ExpandableCell
        
        let weather = weatherArray[indexPath.row]
        
        let weatherViewModel = WeatherViewModel(model: weather)
        collectcell.displayWeatherInCell(using: weatherViewModel)
                
        return collectcell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.contentOffset.y < 0 ||
            collectionView.contentOffset.y > collectionView.contentSize.height - collectionView.frame.height {
            return
        }
        
        
        let dampingRatio: CGFloat = 0.8
        let initialVelocity: CGVector = CGVector.zero
        let springParameters: UISpringTimingParameters = UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: initialVelocity)
        let animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: springParameters)
        
        
        self.view.isUserInteractionEnabled = false
        
        if let selectedCell = expandedCell {
            isStatusBarHidden = false
            
            animator.addAnimations {
                selectedCell.collapse()
                
                for cell in self.hiddenCells {
                    cell.show()
                }
            }
            
            animator.addCompletion { _ in
                collectionView.isScrollEnabled = true
                
                self.expandedCell = nil
                self.hiddenCells.removeAll()
            }
        } else {
            isStatusBarHidden = true
            
            collectionView.isScrollEnabled = false
            
            let selectedCell = collectionView.cellForItem(at: indexPath)! as! ExpandableCell
            let frameOfSelectedCell = selectedCell.frame
            
            expandedCell = selectedCell
            hiddenCells = collectionView.visibleCells.map { $0 as! ExpandableCell }.filter { $0 != selectedCell }
            
            animator.addAnimations {
                selectedCell.expand(in: collectionView)
                
                for cell in self.hiddenCells {
                    cell.hide(in: collectionView, frameOfSelectedCell: frameOfSelectedCell)
                }
            }
        }
        
        
        animator.addAnimations {
            self.setNeedsStatusBarAppearanceUpdate()
        }

        animator.addCompletion { _ in
            self.view.isUserInteractionEnabled = true
        }
        
        animator.startAnimation()
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




