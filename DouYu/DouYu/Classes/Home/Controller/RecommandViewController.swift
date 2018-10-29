//
//  RecommandViewController.swift
//  DouYu
//
//  Created by mye on 2018/9/13.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

private let kLayoutItemMargin : CGFloat = 10.0
private let kLayoutItemWidth : CGFloat = (kScreenW - 3 * kLayoutItemMargin) / 2
private let kLayoutItemHeight : CGFloat = kLayoutItemWidth * 3 / 4
private let kLayoutPrettyItemHeight : CGFloat = kLayoutItemWidth * 4 / 3
private let kAdvertisementView : CGFloat = kScreenW * 3 / 8
private let kGameView : CGFloat = 90.0;
private let kHeaderHeight : CGFloat = 50.0
private let kNormalCellID : String = "kNormalCellID"
private let kPrettyCellID : String = "kPrettyCellID"
private let kSectionHeaderID : String = "kSectionHeaderID"

class RecommandViewController: UIViewController {

    private lazy var recommandViewModel : RecommandViewModel = RecommandViewModel()
    
    private lazy var advertisementView : AdvertisementView = {
        let advertisementView = AdvertisementView.advertisementView()
        advertisementView.frame = CGRect.init(x: 0, y: -kAdvertisementView - kGameView, width: kScreenW, height: kAdvertisementView)
        return advertisementView
    }()
    
    private lazy var gameView : GameView = {
        let gameView = GameView.gameView()
        gameView.frame = CGRect.init(x: 0, y: -kGameView, width: kScreenW, height: kGameView)
        return gameView
    }()
    
    private lazy var collectionView : UICollectionView = {[weak self] in
        let height = kScreenH - kStatusBarH - kNavigationBarH - kTabBarH - kTitleViewH
        let frame = self?.view.bounds
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: kLayoutItemWidth, height: kLayoutItemHeight)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = kLayoutItemMargin
        layout.sectionInset = UIEdgeInsetsMake(0, kLayoutItemMargin, 0, kLayoutItemMargin)
        layout.headerReferenceSize = CGSize.init(width: kScreenW, height: kHeaderHeight)
        let collectionView = UICollectionView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: CGFloat(kScreenW), height: height)), collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets.init(top: kAdvertisementView + kGameView, left: 0, bottom: 0, right: 0);
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib.init(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib.init(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib.init(nibName: "HeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderID)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. 设置UI
        setUI()
        
        // 2. 加载数据
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RecommandViewController {
    // Mark:- UI
    private func setUI() -> Void {
        self.view.addSubview(collectionView)
        collectionView.addSubview(advertisementView)
        collectionView.addSubview(gameView)
    }
    
    private func loadData() -> Void {
        recommandViewModel.requestData {[unowned self] in
            self.collectionView.reloadData()
            self.gameView.anchorGroups = self.recommandViewModel.anchorGroups
        }
        
        // 轮播图
        recommandViewModel.requestAdvertiseData {
            self.advertisementView.advertises = self.recommandViewModel.advertises
        };
    }
}

extension RecommandViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommandViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let anchorGroup = recommandViewModel.anchorGroups[section]
        return anchorGroup.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let anchorGroup = recommandViewModel.anchorGroups[indexPath.section]
        let anchorModel = anchorGroup.anchors[indexPath.item]
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
            cell.anchorModel = anchorModel
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionViewNormalCell
            cell.anchorModel = anchorModel
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderID, for: indexPath) as! HeaderReusableView
        
        let anchorGroup = recommandViewModel.anchorGroups[indexPath.section]
        headerView.anchorGroup = anchorGroup
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize.init(width: kLayoutItemWidth, height: kLayoutPrettyItemHeight)
        } else {
            return CGSize.init(width: kLayoutItemWidth, height: kLayoutItemHeight)
        }
    }
}

