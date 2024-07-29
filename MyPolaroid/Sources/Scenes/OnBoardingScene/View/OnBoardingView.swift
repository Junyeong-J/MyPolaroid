//
//  OnBoardingView.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/22/24.
//

import UIKit
import SnapKit

final class OnBoardingView: BaseView {
    
    private let serviceTitleImageView = CustomImageView("launch")
    private let mainPosterImageView = CustomImageView("launchImage")
    let appStartButton = PointButton(title: .start)
    private let myName: UILabel = {
        let label = UILabel()
        label.text = "전준영"
        label.font = Font.bold20
        return label
    }()
    
    override func configureHierarchy() {
        [mainPosterImageView, serviceTitleImageView, myName, appStartButton].forEach{ addSubview($0) }
    }
    
    override func configureLayout() {
        mainPosterImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(30)
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(mainPosterImageView.snp.width)
        }
        
        serviceTitleImageView.snp.makeConstraints { make in
            make.bottom.equalTo(mainPosterImageView.snp.top).offset(-20)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            make.height.equalTo(100)
        }
        
        myName.snp.makeConstraints { make in
            make.top.equalTo(mainPosterImageView.snp.bottom).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        appStartButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
}
