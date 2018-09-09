//
//  MainViewController.swift
//  DouYu
//
//  Created by 肖仲文 on 2018/7/30.
//  Copyright © 2018 肖仲文. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc(storyboardName: "Home")
        addChildVc(storyboardName: "Live")
        addChildVc(storyboardName: "Follow")
        addChildVc(storyboardName: "Profile")
    }

    private func addChildVc(storyboardName : String) {
        let childVc = UIStoryboard.init(name:storyboardName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVc)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
