//
//  MainViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/23/24.
//

import UIKit

final class MainViewController: BaseViewController<MainView> {
    
    private let myProfileImageView = ProfileImage(profile: "profile_1", corner: 20, border: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(image: myProfileImageView)
    }
    
    
    override func configureView() {
        super.configureView()
    }
    
    
    
}
