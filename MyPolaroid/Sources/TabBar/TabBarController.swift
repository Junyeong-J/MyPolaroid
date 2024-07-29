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

        tabBar.tintColor = .myAppBlack
        tabBar.unselectedItemTintColor = .myAppGray
        
        let trend = TrendsByTopicMainViewController()
        let nav1 = UINavigationController(rootViewController: trend)
        nav1.tabBarItem = UITabBarItem(title: NavigationTitle.ourTopic.title, image: UIImage(named: "tab_trend"), tag: 0)
        
//        let like = LikeListViewController()
//        let nav2 = UINavigationController(rootViewController: like)
//        nav2.tabBarItem = UITabBarItem(title: "좋아요", image: UIImage(systemName: "hand.thumbsup.fill"), tag: 0)
//        
        let search = PhotoSearchViewController()
        let nav3 = UINavigationController(rootViewController: search)
        nav3.tabBarItem = UITabBarItem(title: NavigationTitle.searchPhoto.title, image: UIImage(named: "tab_search"), tag: 2)
        
        let like = MyPolaroidViewController()
        let nav4 = UINavigationController(rootViewController: like)
        nav4.tabBarItem = UITabBarItem(title: NavigationTitle.myPolaroid.title, image: UIImage(named: "tab_like"), tag: 3)
        
        
        setViewControllers([nav1, nav3, nav4], animated: true)
    }
    
}
