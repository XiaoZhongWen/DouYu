//
//  AdvertisementCell.swift
//  DouYu
//
//  Created by mye on 2018/9/25.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

class AdvertisementCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var advertiseModel: AdvertiseModel? {
        didSet {
            guard let advertiseModel = advertiseModel else {return}
            imageView .sd_setImage(with: NSURL.init(string: advertiseModel.pic_url)! as URL, completed: nil)
            titleLabel.text = advertiseModel.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
