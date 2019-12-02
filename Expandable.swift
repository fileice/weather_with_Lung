//
//  Expandable.swift
//  weather_with_Lung
//
//  Created by CHIOU LI-SHIAU on 2019/9/27.
//  Copyright © 2019 CHIOU LI-SHIAU. All rights reserved.
//

import UIKit

protocol Expandable {
    func collapse()
    func expand(in collectionView: UICollectionView)
}
