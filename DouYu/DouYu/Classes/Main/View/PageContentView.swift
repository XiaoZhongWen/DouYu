//
//  PageContentView.swift
//  DouYu
//
//  Created by mye on 2018/9/10.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

let UICollectionViewCellIdentifier = "UICollectionViewCellIdentifier"

protocol PageContentViewDelegate : class {
    func pageContentViewDidScroll(pageContentView : PageContentView, sourceIndex : Int, targetIndex : Int, progress : CGFloat) -> Void;
}

class PageContentView: UIView {
    
    private var startScroll : Bool = true
    private let childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var currentOffset : CGFloat = 0.0
    weak var delegate : PageContentViewDelegate?
    
    private lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        let collectionView = UICollectionView.init(frame: (self?.bounds)!, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(object_getClass(UICollectionViewCell()), forCellWithReuseIdentifier: UICollectionViewCellIdentifier)
        
        return collectionView
    }();
    
    init(frame : CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        // 设置UI
        for vc in childVcs {
            self.parentViewController?.addChildViewController(vc)
        }
        setUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    // MARK:- 设置UI
    private func setUI() -> Void {
        // 1. 添加UICollectionView
        addSubview(collectionView)
    }
    
    // MARK:- 显示相应的内容视图
    func showContentViewAtIndex(index : Int) -> Void {
        startScroll = false
        let offsetX = CGFloat(index) * kScreenW
        self.collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: false)
    }
}

extension PageContentView : UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK:- UICollectionView 数据源
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: UICollectionViewCellIdentifier, for: indexPath);
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let vc = self.childVcs[indexPath.item]
        cell.contentView.addSubview(vc.view)
        return cell
    }
    
    // MARK:- UICollectionView 滑动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startScroll = true
        currentOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if !startScroll {
            return
        }
        
        var sourceIndex = 0
        var targetIndex = 0
        var progress : CGFloat = 0.0
        
        if scrollView.contentOffset.x > currentOffset {
            // 左滑
            sourceIndex = Int(scrollView.contentOffset.x / CGFloat(kScreenW))
            targetIndex = sourceIndex + 1
            progress = CGFloat(Int(scrollView.contentOffset.x) % Int(kScreenW)) / CGFloat(kScreenW)
            if (scrollView.contentOffset.x - currentOffset) == CGFloat(kScreenW) {
                targetIndex = sourceIndex
                sourceIndex = sourceIndex - 1
                progress = 1.0
            }
        } else {
            // 右滑
            targetIndex = Int(scrollView.contentOffset.x / CGFloat(kScreenW))
            sourceIndex = targetIndex + 1
            progress = 1.0 - CGFloat(Int(scrollView.contentOffset.x) % Int(kScreenW)) / CGFloat(kScreenW)
        }
        delegate?.pageContentViewDidScroll(pageContentView: self, sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
    }
}
