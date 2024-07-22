//
//  ProfileSettingViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/22/24.
//

import UIKit

final class ProfileSettingViewController: BaseViewController<ProfileSettingView> {
    
    let viewModel = ProfileSettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        bindData()
        addTargets()
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
        viewModel.outputValidationText.bind { [weak self] value in
            self?.rootView.stateLabel.text = value
        }
        
        viewModel.outputValid.bind { [weak self] value in
            self?.rootView.successButton.backgroundColor = value ? .myAppMain : .myAppGray
            self?.rootView.successButton.isEnabled = value
        }
        
        viewModel.outputMbtiButtonBool.bind { [weak self] value in
            self?.selectedMbtiButton(value)
        }
    }
    
    private func addTargets() {
        for mbtiButton in rootView.mbtiButtons {
            mbtiButton.addTarget(self, action: #selector(mbtiButtonClicked), for: .touchUpInside)
        }
        
        rootView.successButton.addTarget(self, action: #selector(successButtonClicked), for: .touchUpInside)
    }
    
    private func selectedMbtiButton(_ mbtiButtonValue: [String: Bool]?) {
        for button in rootView.mbtiButtons {
            guard let title = button.configuration?.title else { return }
            let isSelected = mbtiButtonValue?[title] ?? false
            button.backgroundColor = isSelected ? .myAppMain : .myAppWhite
            button.setTitleColor(isSelected ? .myAppWhite : .myAppGray, for: .normal)
        }
    }
    
    @objc private func mbtiButtonClicked(_ sender: UIButton) {
        guard let buttonTitle = sender.configuration?.title else {return}
        viewModel.inputMbtiButtonTitle.value = buttonTitle
    }
    
    @objc private func successButtonClicked() {
        
    }
}

extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.inputNickname.value = textField.text
    }
}
