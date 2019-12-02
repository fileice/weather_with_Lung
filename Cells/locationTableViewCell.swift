//
//  locationTableViewCell.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/11/13.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit

class locationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblComfort: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblParameter: UILabel!
    @IBOutlet weak var view: UIView!
    
    
    @IBOutlet weak var backGroundImageView: UIImageView!
    
    var cornerRadius: CGFloat = 15
    var shadowOffsetWidth: Int = 0
    var shadowOffsetHeight: Int = 3
    var shadowOpacity: Float = 0.5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureCell() {
        
        // image 透明度
        //self.backGroundImageView.alpha = 0.5
        
        // image 貼合設置size
        self.backGroundImageView.layer.contentsGravity = CALayerContentsGravity.resize
        
        // 設定layer的圓角
        self.backGroundImageView.layer.cornerRadius = cornerRadius
        self.view.layer.cornerRadius = cornerRadius
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        // masksToBounds屬性若被設置為true，會將超過邊筐外的sublayers裁切掉
        //self.weatherImage.layer.masksToBounds = false
        
        // 陰影設置位置
        self.backGroundImageView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        
        // 設定layer shadow的透明度
        self.backGroundImageView.layer.shadowOpacity = shadowOpacity
        
        // 陰影路徑
        self.backGroundImageView.layer.shadowPath = shadowPath.cgPath
        
    }

    func displayWeatherInCell(using viewModel: WeatherViewModel) {
        let dsteString = viewModel.date
        let date = dsteString.split(separator: " ")
        let stringDate = date[0]
    
        lblTitle.text = viewModel.title
        lblDate.text = String(stringDate)
        lblComfort.text = viewModel.comfort
        lblParameter.text = viewModel.parameter
        lblTemp.text = viewModel.temperature + "℃"
        backGroundImageView.alpha = 0.5
        
        if viewModel.weatherCI.contains("晴") {
            backGroundImageView.image = UIImage(named: "city_weather_pic_sun")
        } else if viewModel.weatherCI.contains("雨") {
            backGroundImageView.image = UIImage(named: "city_weather_pic_rain")
        } else {
            backGroundImageView.image = UIImage(named: "city_weather_pic_cloud")
        }
    }
    
}
