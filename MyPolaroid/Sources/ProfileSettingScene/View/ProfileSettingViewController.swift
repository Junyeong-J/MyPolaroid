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
    }
}

extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.inputNickname.value = textField.text
    }
}
