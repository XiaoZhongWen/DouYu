//
//  CollectionViewNormalCell.swift
//  DouYu
//
//  Created by mye on 2018/9/13.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewNormalCell: UICollectionViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineLabel: UIButton!
    
    var anchorModel : AnchorModel? {
        didSet {
            guard let anchorModel = anchorModel else {
                return
            }
            mainImageView.sd_setImage(with: URL.init(string: anchorModel.room_src), placeholderImage: UIImage.init(named: "Img_default"))
            roomNameLabel.text = anchorModel.room_name
            nickNameLabel.text = anchorModel.nickname
            let online = abs(Int32(anchorModel.online) ?? 0)
            let number = CGFloat(online)
            var numberDesc : String = "\(String(describing: online))"
            if number > 10000 {
                numberDesc = String.init(format: "%.1f万", number / 10000)
            }
            onlineLabel.setTitle(numberDesc, for: UIControlState.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageView.layer.masksToBounds = true
        mainImageView.layer.cornerRadius = 5.0
        mainImageView.contentMode = UIViewContentMode.scaleAspectFill
    }
}
