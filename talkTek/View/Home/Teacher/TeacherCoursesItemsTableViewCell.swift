//
//  TeacherCoursesItemsTableViewCell.swift
//  talkTek
//
//  Created by Mac on 2017/12/23.
//  Copyright © 2017年 Talktek Inc. All rights reserved.
//

import UIKit

class TeacherCoursesItemsTableViewCell: UITableViewCell {

  @IBOutlet weak var overview_ImageView: UIImageView!
  
  @IBOutlet weak var author_ImageView: UIImageView!
  
  @IBOutlet weak var authorName_Label: UILabel!
  
  @IBOutlet weak var courseTitle_Label: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  override func layoutSubviews() {
    author_ImageView.layer.cornerRadius = author_ImageView.bounds.height / 2
    author_ImageView.layer.borderWidth = 2.0
    author_ImageView.layer.borderColor = UIColor.white.cgColor
    author_ImageView.clipsToBounds = true
  }

}
