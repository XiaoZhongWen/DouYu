//
//  PageTitleView.swift
//  DouYu
//
//  Created by 肖仲文 on 2018/9/5.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

let kScrollLineH : CGFloat = 2.0
let kPageTitleViewTag = 1000
let kAnimationDuration = 0.15

let normalColor = (r: 85.0, g: 85.0, b: 85.0)
let selectedColor = (r: 253.0, g: 138.0, b: 49.0)

protocol PageTitleViewDelegate : class {
    func didSelectedTitleIndex(pageTitleView : PageTitleView, selectedIndex : Int) -> Void
}

class PageTitleView: UIView {

    private var selectedItemIndex = 0
    private var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = self.bounds
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }();
    
    private lazy var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        let size = self.frame.size
        lineView.frame = CGRect.init(origin: CGPoint.init(x: 0, y: size.height - 1.0), size: CGSize.init(width: size.width, height: 1.0))
        return lineView;
    }();
    
    private lazy var bottomItemLineView : UIView = {
        let bottomItemLineView = UIView()
        bottomItemLineView.backgroundColor = UIColor.init(r: CGFloat(selectedColor.r), g: CGFloat(selectedColor.g), b: CGFloat(selectedColor.b))
        let y = self.frame.size.height - kScrollLineH
        let width = (CGFloat)(kScreenW) / (CGFloat)(self.titles.count)
        bottomItemLineView.frame = CGRect.init(origin: CGPoint.init(x: 0, y: y), size: CGSize.init(width: width, height: 1.0))
        return bottomItemLineView;
    }();
    
    init(frame : CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        // 1. 设置UI
        setUI()
        // 2. 设置选中的标题
        self.setSelectedTitleAtIndex(index: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelectedTitleAtIndex(index : Int) -> Void {
        // 1. 设置bottomItemLineView的x值
        var bottomItemLineViewFrame = self.bottomItemLineView.frame
        let width = (CGFloat)(kScreenW) / (CGFloat)(self.titles.count)
        bottomItemLineViewFrame.origin.x = (CGFloat)(index) * width
        UIView.animate(withDuration: kAnimationDuration) {
            self.bottomItemLineView.frame = bottomItemLineViewFrame
        }
        
        // 2. 调整标题颜色
        let titleLabel = self.viewWithTag(self.selectedItemIndex + kPageTitleViewTag) as! UILabel
        titleLabel.textColor = UIColor.init(r: CGFloat(normalColor.r), g: CGFloat(normalColor.g), b: CGFloat(normalColor.b))
        let selectedLabel : UILabel = self.viewWithTag(index + kPageTitleViewTag) as! UILabel
        selectedLabel.textColor = UIColor.init(r: CGFloat(selectedColor.r), g: CGFloat(selectedColor.g), b: CGFloat(selectedColor.b))
        self.selectedItemIndex = index
    }
}

extension PageTitleView {
    // MARK:- 设置UI
    private func setUI() -> Void {
        // 1. 添加scrollView
        addSubview(scrollView)
        // 2. 添加标题
        let titleLabelY : CGFloat = 0.0
        let titleLabelW : CGFloat = (CGFloat)(kScreenW) / (CGFloat)(self.titles.count)
        let titleLabelH : CGFloat = self.bounds.size.height - kScrollLineH
        for (index, title) in self.titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.isUserInteractionEnabled = true
            titleLabel.font = UIFont.systemFont(ofSize: 16.0)
            titleLabel.textColor = UIColor.init(r: CGFloat(normalColor.r), g: CGFloat(normalColor.g), b: CGFloat(normalColor.b))
            titleLabel.textAlignment = .center
            titleLabel.text = title
            titleLabel.tag = index + kPageTitleViewTag
            let titleLabelX : CGFloat = titleLabelW * (CGFloat)(index)
            titleLabel.frame = CGRect.init(x: titleLabelX, y: titleLabelY, width: titleLabelW, height: titleLabelH)
            self.scrollView.addSubview(titleLabel)
            let tapGesture = UITapGestureRecognizer()
            tapGesture.addTarget(self, action: #selector(self.tapTitleItem(tapGesture:)))
            titleLabel.addGestureRecognizer(tapGesture)
        }
        // 3. 添加底线
        self.addSubview(self.lineView)
        self.addSubview(self.bottomItemLineView)
    }
    
    // MARK:- 滑动
    func didScroll(sourceIndex : Int, targetIndex: Int, progress : CGFloat) -> Void {
        print("sourceIndex: \(sourceIndex), targetIndex: \(targetIndex), progress: \(progress)")
        
        let sourceLabel = scrollView.viewWithTag(sourceIndex + kPageTitleViewTag) as? UILabel
        let targetLabel = scrollView.viewWithTag(targetIndex + kPageTitleViewTag) as? UILabel
        var startX : CGFloat = 0.0
        var width : CGFloat = 0.0
        if sourceLabel == nil || targetLabel == nil {
            return
        } else {
            startX = (sourceLabel?.frame.origin.x)!
            width = (sourceLabel?.frame.size.width)!
        }
        let offset = CGFloat(targetIndex - sourceIndex) * width * progress
        self.bottomItemLineView.frame.origin.x = startX + offset
        
        let deltaR = CGFloat(selectedColor.r - normalColor.r)
        let deltaG = CGFloat(selectedColor.g - normalColor.g)
        let deltaB = CGFloat(selectedColor.b - normalColor.b)
        sourceLabel?.textColor
            = UIColor.init(r: CGFloat(selectedColor.r) - deltaR * progress,
                           g: CGFloat(selectedColor.g) - deltaG * progress,
                           b: CGFloat(selectedColor.b) - deltaB * progress)
        targetLabel?.textColor
            = UIColor.init(r: CGFloat(normalColor.r) + deltaR * progress,
                           g: CGFloat(normalColor.g) + deltaG * progress,
                           b: CGFloat(normalColor.b) + deltaB * progress)
        
        selectedItemIndex = targetIndex
    }
}

extension PageTitleView {
    // MARK:- UI事件
    @objc func tapTitleItem(tapGesture : UITapGestureRecognizer) -> Void {
        let tag = tapGesture.view?.tag
        let currentIndex = tag! - kPageTitleViewTag
        self.setSelectedTitleAtIndex(index: currentIndex)
        self.delegate?.didSelectedTitleIndex(pageTitleView: self, selectedIndex: currentIndex)
    }
}
