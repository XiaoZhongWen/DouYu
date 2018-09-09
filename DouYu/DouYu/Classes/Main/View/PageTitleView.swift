//
//  PageTitleView.swift
//  DouYu
//
//  Created by 肖仲文 on 2018/9/5.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

let kScrollLineH : CGFloat = 2.0

class PageTitleView: UIView {

    private var titles : [String]
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = self.bounds
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }();
    
    init(frame : CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        // 设置UI
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView {
    // MARK:- 设置标题
    private func setUI() -> Void {
        // 1. 添加scrollView
        addSubview(scrollView)
        // 2. 添加标题
        let titleLabelY : CGFloat = 0.0
        let titleLabelW : CGFloat = (CGFloat)(kScreenW) / (CGFloat)(self.titles.count)
        let titleLabelH : CGFloat = self.bounds.size.height - kScrollLineH
        for (index, title) in self.titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 16.0)
            titleLabel.textColor = UIColor.darkGray
            titleLabel.textAlignment = .center
            titleLabel.text = title
            titleLabel.tag = index
            let titleLabelX : CGFloat = titleLabelW * (CGFloat)(index)
            titleLabel.frame = CGRect.init(x: titleLabelX, y: titleLabelY, width: titleLabelW, height: titleLabelH)
            self.scrollView.addSubview(titleLabel)
        }
    }
}
