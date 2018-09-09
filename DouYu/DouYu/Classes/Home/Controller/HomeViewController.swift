//
//  HomeViewController.swift
//  DouYu
//
//  Created by 肖仲文 on 2018/9/4.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

let kTitleViewH = 40.0

class HomeViewController: UIViewController {
    
    private lazy var pageTitleView : PageTitleView = {
        let frame : CGRect = CGRect.init(origin: CGPoint.init(x: 0, y: kStatusBarH + kNavigationBarH), size: CGSize.init(width: kScreenW, height: kTitleViewH))
        let titles : [String] = ["推荐", "游戏", "娱乐", "趣玩"]
        return PageTitleView(frame: frame, titles: titles)
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. 设置UI
        setUI();
        
        // 2. 添加pageTitleView
        view.addSubview(pageTitleView)
    }
}

// MARK:- 设置UI界面
extension HomeViewController {
    private func setUI() -> Void {
        // 1. 设置导航栏
        setNavigationBar()
    }
    
    private func setNavigationBar() -> Void {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "logo")
        
        let size = CGSize.init(width: 35.0, height: 40.0)
        let historyItem = UIBarButtonItem.init(imageName: "image_my_history", highLightImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem.init(imageName: "btn_search", highLightImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem.init(imageName: "Image_scan", highLightImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}
