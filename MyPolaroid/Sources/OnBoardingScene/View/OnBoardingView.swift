//
//  OnBoardingView.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/22/24.
//

import UIKit
import SnapKit

class OnBoardingView: BaseView {
    
    let serviceTitleImageView = CustomImageView("launch")
    let mainPosterImageView = CustomImageView("launchImage")
    let myName = UILabel()
    let appStratButton = PointButton(title: .start)
    
    override func configureHierarchy() {
        addSubview(serviceTitleImageView)
        addSubview(mainPosterImageView)
        addSubview(myName)
        addSubview(appStratButton)
    }
    
    override func configureLayout() {
        mainPosterImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(30)
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(mainPosterImageView.snp.width)
        }
        
        serviceTitleImageView.snp.makeConstraints { make in
            make.bottom.equalTo(mainPosterImageView.snp.top).offset(-20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            make.height.equalTo(100)
        }
        
        myName.snp.makeConstraints { make in
            make.top.equalTo(mainPosterImageView.snp.bottom).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        appStratButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        myName.text = "전준영"
    }
    
}
