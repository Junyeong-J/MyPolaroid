//
//  ProfileSettingViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/22/24.
//

import UIKit

final class ProfileSettingViewController: BaseViewController<ProfileSettingView> {
    
    private let viewModel = ProfileSettingViewModel()
    var viewType: NavigationTitle = .profileSetting
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        bindData()
        tapGesture()
        addTargets()
        setUI()
    }
    
    override func configureView() {
        super.configureView()
    }
    
}

extension ProfileSettingViewController {
    private func configureTextField() {
        rootView.nicknameTextField.delegate = self
    }
    
    private func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.outputUserDefaultsData.bind { [weak self] data in
            self?.updateSetUI(data)
        }
        
        viewModel.outputValidationText.bind { [weak self] value in
            self?.rootView.stateLabel.text = value
        }
        
        viewModel.outputNicknameValid.bind { [weak self] value in
            self?.rootView.stateLabel.textColor = value ? .myAppMain : .myAppLightRed
        }
        
        viewModel.outputMbtiButtonBool.bind { [weak self] value in
            self?.selectedMbtiButton(value)
        }
        
        viewModel.outputButtonValid.bind { [weak self] value in
            self?.rootView.successButton.backgroundColor = value ? .myAppMain : .myAppGray
            self?.rootView.successButton.isEnabled = value
        }
    }
    
    private func updateSetUI(_ data: (nickname: String?, profileName: String?, mbti: [String: Bool]?, isUser: Bool)) {
        rootView.nicknameTextField.text = data.nickname
        selectedMbtiButton(data.mbti)
    }
    
    private func tapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageViewClicked))
        rootView.profileImageView.addGestureRecognizer(tapGesture)
        rootView.profileImageView.isUserInteractionEnabled = true
    }
    
    private func addTargets() {
        for mbtiButton in rootView.mbtiButtons {
            mbtiButton.addTarget(self, action: #selector(mbtiButtonClicked), for: .touchUpInside)
        }
        
        rootView.successButton.addTarget(self, action: #selector(successButtonClicked), for: .touchUpInside)
        rootView.withdrawal.addTarget(self, action: #selector(withdrawalClicked), for: .touchUpInside)
    }
    
    private func setUI() {
        if viewType == .profileSetting {
            rootView.successButton.isHidden = false
            rootView.withdrawal.isHidden = true
        } else {
            rootView.withdrawal.isHidden = false
            rootView.successButton.isHidden = true
            tabBarController?.tabBar.isHidden = true
        }
    }
    
    private func selectedMbtiButton(_ mbtiButtonValue: [String: Bool]?) {
        for button in rootView.mbtiButtons {
            guard let title = button.configuration?.title else { return }
            let isSelected = mbtiButtonValue?[title] ?? false
            var configuration = button.configuration
            configuration?.baseForegroundColor = isSelected ? .myAppWhite : .myAppGray
            button.configuration = configuration
            button.backgroundColor = isSelected ? .myAppMain : .myAppWhite
            button.layer.borderColor = isSelected ? UIColor.myAppMain.cgColor : UIColor.myAppGray.cgColor
        }
    }
    
    @objc private func profileImageViewClicked() {
        let vc = EditProfileViewController()
        vc.profileImage = rootView.profileImageName
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func mbtiButtonClicked(_ sender: UIButton) {
        guard let buttonTitle = sender.configuration?.title else {return}
        viewModel.inputMbtiButtonTitle.value = buttonTitle
    }
    
    @objc private func successButtonClicked() {
        viewModel.inputSuccessButtonClicked.value = rootView.profileImageName
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let rootViewController = TabBarController()
        sceneDelegate?.window?.rootViewController = rootViewController
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    @objc private func withdrawalClicked() {
        showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다.", ok: "확인") {
            UserDefaultsManager.shared.clearAllData()
//            self.repository.deleteAll()
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let rootViewController = UINavigationController(rootViewController: OnBoardingViewController())
            sceneDelegate?.window?.rootViewController = rootViewController
            sceneDelegate?.window?.makeKeyAndVisible()
        }
    }
}

extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.inputNickname.value = textField.text
    }
}

extension ProfileSettingViewController: ProfileSetProtocol {
    func selectSetImage(_ profileImageIndex: Int) {
        let selectedImageName = UIImage.profileImage[profileImageIndex]
        rootView.profileImageView.image = UIImage(named: selectedImageName)
        rootView.profileImageName = selectedImageName
    }
}
