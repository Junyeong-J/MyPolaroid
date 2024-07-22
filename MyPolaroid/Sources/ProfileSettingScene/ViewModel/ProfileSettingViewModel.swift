//
//  ProfileSettingViewModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/23/24.
//

import Foundation

final class ProfileSettingViewModel {
    
    var inputNickname: Observable<String?> = Observable(nil)
    var inputMbtiButtonTitle: Observable<String?> = Observable(nil)
    
    var outputValidationText = Observable("")
    var outputValid = Observable(false)
    var outputMbtiButtonBool: Observable<[String: Bool]?> = Observable(nil)
    
    private let mbtiSet: [String: String] = ["E": "I", "I": "E", "S": "N", "N": "S", "T": "F", "F": "T", "J": "P", "P": "J"]
    private var mbtiButtonBool: [String: Bool] = ["E": false, "I": false, "S": false, "N": false, "T": false, "F": false, "J": false, "P": false]
    
    init() {
        inputNickname.bind { [weak self] nickname in
            self?.validateNickname(nickname)
        }
        
        inputMbtiButtonTitle.bind { [weak self] buttonTitle in
            self?.mbtiButtonCheck(buttonTitle)
        }
    }
    
    private func mbtiButtonCheck(_ title: String?) {
        guard let title = title, let set = mbtiSet[title]else {return}
        mbtiButtonBool[title]?.toggle()
        if mbtiButtonBool[title] == true {
            mbtiButtonBool[set] = false
        }
        outputMbtiButtonBool.value = mbtiButtonBool
    }
    
    private func validateNickname(_ nickname: String?) {
        guard let text = nickname else {
            outputValidationText.value = NicknameError.ect.eachError
            outputValid.value = false
            return
        }
        
        do {
            try requestNickname(text: text)
            outputValidationText.value = NicknameError.correct.eachError
            outputValid.value = true
        } catch let error as NicknameError {
            outputValidationText.value = error.eachError
            outputValid.value = false
        } catch {
            outputValidationText.value = NicknameError.ect.eachError
            outputValid.value = false
        }
    }
    
    private func requestNickname(text: String) throws {
        if !textLength(text: text) {
            throw NicknameError.count
        }
        
        if text.range(of: "\\d", options: .regularExpression) != nil {
            throw NicknameError.characterError("숫자")
        }
        
        let characters = ["@", "#", "$", "%"]
        for char in characters {
            if text.contains(char) {
                throw NicknameError.characterError(char)
            }
        }
        
    }
    
    private func textLength(text: String) -> Bool {
        return text.count >= 2 && text.count < 10
    }
    
}
