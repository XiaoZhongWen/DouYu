

//
//  GameView.swift
//  DouYu
//
//  Created by mye on 2018/9/26.
//  Copyright © 2018 肖仲文. All rights reserved.
//

private let kGameCellID = "GameCell"

import UIKit

class GameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    class func gameView() -> GameView {
        return Bundle.main.loadNibNamed("GameView", owner: nil, options: nil)?.first as! GameView
    }
    
    var anchorGroups : [AnchorGroup]? {
        didSet {
            guard anchorGroups != nil else {return}
        
            anchorGroups?.remove(at: 0)
            anchorGroups?.remove(at: 0)
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize.init(width: 80.0, height: 90.0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 10.0, 0, 10.0)
        self.collectionView.register(UINib.init(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.bounces = true
        self.collectionView.isPagingEnabled = false
        self.collectionView.dataSource = self
    }
}

extension GameView : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! GameCell
        let anchorGroup = anchorGroups![indexPath.item]
        gameCell.anchorGroup = anchorGroup
        return gameCell
    }
}
