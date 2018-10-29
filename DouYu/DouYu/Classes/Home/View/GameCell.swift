//
//  GameCell.swift
//  DouYu
//
//  Created by mye on 2018/9/26.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

class GameCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    
    var anchorGroup : AnchorGroup? {
        didSet {
            guard let anchorGroup = anchorGroup else {return}
            imageView.sd_setImage(with: NSURL.init(string: anchorGroup.icon_url)! as URL, placeholderImage: UIImage.init(named: "home_more_btn"))
            gameNameLabel.text = anchorGroup.tag_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = imageView.bounds.size.width * 0.5
        imageView.layer.masksToBounds = true
    }

}
