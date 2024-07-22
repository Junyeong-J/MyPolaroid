//
//  OnBoardingViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/22/24.
//

import UIKit

final class OnBoardingViewController: BaseViewController<OnBoardingView>{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
    }
    
    override func configureView() {
        super.configureView()
    }
    
}

extension OnBoardingViewController {
    private func addTarget() {
        rootView.appStartButton.addTarget(self, action: #selector(appStartButtonClicked), for: .touchUpInside)
    }
    
    @objc private func appStartButtonClicked() {
        let vc = ProfileSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
