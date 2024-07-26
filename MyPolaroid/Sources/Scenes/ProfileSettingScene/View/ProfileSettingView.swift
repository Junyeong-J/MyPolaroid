//
//  ProfileSettingView.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/22/24.
//

import UIKit
import SnapKit

final class ProfileSettingView: BaseView {
    
    var profileImageName: String = ""
    private let mbtiButtonTitles = ["E", "S", "T", "J", "I", "N", "F", "P"]
    
    private let cameraImageView = CameraImage()
    lazy var profileImageView: ProfileImage = {
        
        if let profileName = UserDefaultsManager.shared.profileName, !profileName.isEmpty {
            print(profileName)
            profileImageName = profileName
            return ProfileImage(profile: profileImageName, corner: 50, border: 3)
        } else {
            let index = Int.random(in: 0..<UIImage.profileImage.count)
            profileImageName = UIImage.profileImage[index]
            return ProfileImage(profile: profileImageName, corner: 50, border: 3)
        }
        
        
    }()
    
    let nicknameTextField = NicknameTextField(style: .nickname)
    let stateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = Font.regular13
        return label
    }()
    private let mbtiLabel: UILabel = {
        let label = UILabel()
        label.text = "MBTI"
        label.font = Font.bold20
        return label
    }()
    private let mbtiView = UIView()
    lazy var mbtiButtons: [UIButton] = {
        return mbtiButtonTitles.enumerated().map { index, title in
            let button = UIButton(configuration: .circleStyle(title: title), primaryAction: nil)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.myAppGray.cgColor
            button.layer.cornerRadius = 25
            button.tag = index
            return button
        }
    }()
    let successButton = PointButton(title: .complete)
    
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(cameraImageView)
        addSubview(nicknameTextField)
        addSubview(stateLabel)
        addSubview(mbtiLabel)
        addSubview(mbtiView)
        mbtiButtons.forEach { button in
            mbtiView.addSubview(button)
        }
        addSubview(successButton)
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide).inset(30)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileImageView)
            make.size.equalTo(30)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        stateLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(nicknameTextField)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(10)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.leading.equalTo(nicknameTextField)
            make.top.equalTo(stateLabel.snp.bottom).offset(30)
        }
        
        mbtiView.snp.makeConstraints { make in
            make.top.equalTo(mbtiLabel)
            make.trailing.equalTo(nicknameTextField).inset(20)
            make.height.equalTo(110)
            make.width.equalTo(230)
        }
        
        
        for (index, button) in mbtiButtons.enumerated() {
            button.snp.makeConstraints { make in
                make.size.equalTo(50)
                if index == 0 {//0번 인덱스는 mbtiView의 top와 leading와 같게
                    make.top.leading.equalTo(mbtiView)
                } else if index == 4 {//4번 인덱스는 mbtiView의 bottom와 leading와 같게
                    make.bottom.leading.equalTo(mbtiView)
                } else { // 나머지는 전 인덱스 번호에 10씩 떨어지도록
                    make.top.equalTo(mbtiButtons[index - 1].snp.top)
                    make.leading.equalTo(mbtiButtons[index - 1].snp.trailing).offset(10)
                }
            }
        }
        
        successButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        
    }
    
}

extension ProfileSettingView: NaviProtocol {
    var navigationTitle: String {
        return NavigationTitle.profileSetting.title
    }
}
