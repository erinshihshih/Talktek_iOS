//
//  LifeCollectionViewCell.swift
//  talkTek
//
//  Created by Mac on 2017/12/20.
//  Copyright © 2017年 Talktek Inc. All rights reserved.
//

import UIKit

class LifeCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var heart_Button: UIButton!
  
  @IBOutlet weak var overview_ImageView: UIImageView!
  
  @IBOutlet weak var author_ImageView: UIImageView!
  
  @IBOutlet weak var author_Label: UILabel!
  
  @IBOutlet weak var title_Label: UILabel!
  
  @IBOutlet weak var price_Label: UILabel!
  
  @IBOutlet weak var peopleBought_Label: UILabel!
  
  override func layoutSubviews() {
    author_ImageView.layer.cornerRadius = author_ImageView.bounds.height / 2
    author_ImageView.layer.borderWidth = 2.0
    author_ImageView.layer.borderColor = UIColor.white.cgColor
    author_ImageView.clipsToBounds = true
  }
  
}
