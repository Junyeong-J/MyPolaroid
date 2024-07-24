//
//  TabBarController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/23/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .myAppMain
        tabBar.unselectedItemTintColor = .myAppGray
        
        let search = TrendsByTopicMainViewController()
        let nav1 = UINavigationController(rootViewController: search)
        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "sort"), tag: 0)
        
//        let like = LikeListViewController()
//        let nav2 = UINavigationController(rootViewController: like)
//        nav2.tabBarItem = UITabBarItem(title: "좋아요", image: UIImage(systemName: "hand.thumbsup.fill"), tag: 0)
//        
//        let setting = SettingViewController()
//        let nav3 = UINavigationController(rootViewController: setting)
//        nav3.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
        
        setViewControllers([nav1], animated: true)
    }
    
}
