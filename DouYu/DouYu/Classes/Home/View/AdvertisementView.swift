//
//  AdvertisementView.swift
//  DouYu
//
//  Created by mye on 2018/9/19.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

private let advertisementViewCellID : String = "AdvertisementViewCell"

class AdvertisementView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var advertises:[AdvertiseModel]? {
        didSet {
            guard let advertises = advertises else {
                return
            }
            pageControl.numberOfPages = advertises.count
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.scrollDirection = .horizontal
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "AdvertisementCell", bundle: nil), forCellWithReuseIdentifier: advertisementViewCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension AdvertisementView {
    class func advertisementView() -> AdvertisementView {
        return Bundle.main.loadNibNamed("AdvertisementView", owner: nil, options: nil)![0] as! AdvertisementView
    }
}

extension AdvertisementView : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertises?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: advertisementViewCellID, for: indexPath) as! AdvertisementCell
        let advertiseModel = self.advertises![indexPath.row]
        cell.advertiseModel = advertiseModel
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(index)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(self.bounds.size)
        return self.bounds.size
    }
}
