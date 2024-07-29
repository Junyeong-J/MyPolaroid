//
//  ProfileSettingViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/22/24.
//

import UIKit

final class ProfileSettingViewController: BaseViewController<ProfileSettingView> {
    
    private let viewModel = ProfileSettingViewModel()
    var viewType: NavigationTitle = .profileSetting {
        didSet {
            rootView.viewType = viewType
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboardTapGesture()
        configureNavBarRightBarButtonItem()
        configureTextField()
        bindData()
        tapGesture()
        addTargets()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func configureView() {
        super.configureView()
    }
    
}

extension ProfileSettingViewController {
    private func configureNavBarRightBarButtonItem() {
        if viewType == .editProfile {
            let store = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(storeButtonClicked))
            navigationItem.rightBarButtonItem = store
        }
    }
    
    private func configureTextField() {
        rootView.nicknameTextField.delegate = self
    }
    
    private func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.outputUserDefaultsData.bindAndFire { [weak self] data in
            self?.updateSetUI(data)
        }
        
        viewModel.outputValidationText.bindAndFire { [weak self] value in
            self?.rootView.stateLabel.text = value
        }
        
        viewModel.outputNicknameValid.bindAndFire { [weak self] value in
            self?.rootView.stateLabel.textColor = value ? .myAppMain : .myAppLightRed
        }
        
        viewModel.outputMbtiButtonBool.bindAndFire { [weak self] value in
            self?.selectedMbtiButton(value)
        }
        
        viewModel.outputButtonValid.bindAndFire { [weak self] value in
            self?.updateButtonState(isEnabled: value)
        }
    }
    
    private func updateSetUI(_ data: (nickname: String?, profileName: String?, mbti: [String: Bool]?, isUser: Bool)) {
        rootView.nicknameTextField.text = data.nickname
        selectedMbtiButton(data.mbti)
    }
    
    private func updateButtonState(isEnabled: Bool) {
        rootView.successButton.backgroundColor = isEnabled ? .myAppMain : .myAppGray
        rootView.successButton.isEnabled = isEnabled
        navigationItem.rightBarButtonItem?.isEnabled = isEnabled
    }
    
    private func selectedMbtiButton(_ mbtiButtonValue: [String: Bool]?) {
        for button in rootView.mbtiButtons {
            guard let title = button.configuration?.title else { return }
            let isSelected = mbtiButtonValue?[title] ?? false
            updateButton(button: button, isSelected: isSelected)
        }
    }
    
    private func updateButton(button: UIButton, isSelected: Bool) {
        var configuration = button.configuration
        configuration?.baseForegroundColor = isSelected ? .myAppWhite : .myAppGray
        button.configuration = configuration
        button.backgroundColor = isSelected ? .myAppMain : .myAppWhite
        button.layer.borderColor = isSelected ? UIColor.myAppMain.cgColor : UIColor.myAppGray.cgColor
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
        rootView.successButton.isHidden = viewType != .profileSetting
        rootView.withdrawal.isHidden = viewType == .profileSetting
    }
    
    @objc private func profileImageViewClicked() {
        let vc = EditProfileViewController()
        vc.viewType = viewType
        vc.profileImage = rootView.profileImageName
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func mbtiButtonClicked(_ sender: UIButton) {
        guard let buttonTitle = sender.configuration?.title else {return}
        viewModel.inputMbtiButtonTitle.value = buttonTitle
    }
    
    @objc private func successButtonClicked() {
        viewModel.inputSuccessOrStoreButtonClicked.value = rootView.profileImageName
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let rootViewController = TabBarController()
        sceneDelegate?.window?.rootViewController = rootViewController
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    @objc private func storeButtonClicked() {
        viewModel.inputNickname.value = rootView.nicknameTextField.text
        viewModel.inputSuccessOrStoreButtonClicked.value = rootView.profileImageName
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func withdrawalClicked() {
        showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다.", ok: "확인") {
            self.viewModel.inputWithdrawalClicked.value = ()
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
