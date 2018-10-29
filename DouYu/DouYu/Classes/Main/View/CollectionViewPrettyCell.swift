//
//  CollectionViewPrettyCell.swift
//  DouYu
//
//  Created by mye on 2018/9/14.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewPrettyCell: UICollectionViewCell {

    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchorModel : AnchorModel? {
        didSet {
            guard let anchorModel = anchorModel else {
                return
            }
            
            let online = abs(Int32(anchorModel.online) ?? 0)
            let number = CGFloat(online)
            
            var numberDesc : String = "\(String(describing: online))人在线"
            if number > 10000 {
                numberDesc = String.init(format: "%.1f万人在线", number / 10000)
            }
            onlineLabel.text = numberDesc
            mainImageView.sd_setImage(with: URL.init(string: anchorModel.room_src), placeholderImage: UIImage.init(named: "live_cell_default_phone"))
            cityBtn.setTitle(anchorModel.anchor_city, for: UIControlState.normal)
            nickNameLabel.text = anchorModel.nickname
            onlineLabel.sizeToFit()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainImageView.contentMode = UIViewContentMode.scaleAspectFill
    }

}
