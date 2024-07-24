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
    var outputButtonValid = Observable(false)
    var outputNicknameValid = Observable(false)
    var outputMbtiButtonBool: Observable<[String: Bool]?> = Observable(nil)
    
    private let mbtiSet: [String: String] = ["E": "I", "S": "N", "T": "F", "J": "P"]
    private var mbtiButtonBool: [String: Bool] = ["E": false, "I": false, "S": false, "N": false, "T": false, "F": false, "J": false, "P": false]
    
    init() {
        inputNickname.bind { [weak self] nickname in
            self?.validateNickname(nickname)
        }
        
        inputMbtiButtonTitle.bind { [weak self] buttonTitle in
            self?.mbtiButtonCheck(buttonTitle)
        }
    }
    
    //MARK: - mbti버튼 처리
    private func mbtiButtonCheck(_ title: String?) {
        guard let title = title else {return}
        //mbti버튼의 title을 가져와 같으면 set변수에 key값을 저장, key값에 없으면 value값으로 확인
        let set = mbtiSet[title] ?? mbtiSet.first{ $0.value == title }?.key
        guard let set = set else {return}
        mbtiButtonBool[title]?.toggle()
        if mbtiButtonBool[title] == true {
            mbtiButtonBool[set] = false
        }
        outputMbtiButtonBool.value = mbtiButtonBool
        updateOutputValid()
    }
    
    //MARK: - 닉네임 조건 확인 및 버튼 상태 처리
    private func validateNickname(_ nickname: String?) {
        guard let text = nickname, !text.isEmpty else {
            outputValidationText.value = NicknameError.ect.eachError
            outputNicknameValid.value = false
            updateOutputValid()
            return
        }
        
        do {
            try requestNickname(text: text)
            outputValidationText.value = NicknameError.correct.eachError
            outputNicknameValid.value = true
        } catch let error as NicknameError {
            outputValidationText.value = error.eachError
            outputNicknameValid.value = false
        } catch {
            outputValidationText.value = NicknameError.ect.eachError
            outputNicknameValid.value = false
        }
        
        updateOutputValid()
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
    
    //MARK: - 버튼상태
    private func updateOutputValid() {
        let trueCount = mbtiButtonBool.values.filter { $0 }.count
        outputButtonValid.value = (trueCount == 4) && outputNicknameValid.value
    }
}