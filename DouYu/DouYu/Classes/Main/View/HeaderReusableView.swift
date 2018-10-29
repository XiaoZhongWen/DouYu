//
//  HeaderReusableView.swift
//  DouYu
//
//  Created by mye on 2018/9/13.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tagNameLabel: UILabel!
    
    var anchorGroup : AnchorGroup? {
        didSet {
            iconImageView.image = UIImage.init(named: anchorGroup?.icon_name ?? "home_header_normal")
            tagNameLabel.text = anchorGroup?.tag_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
