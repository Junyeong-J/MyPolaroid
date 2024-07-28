//
//  ProfileSettingViewModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/23/24.
//

import Foundation

final class ProfileSettingViewModel {
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputNickname: Observable<String?> = Observable(nil)
    var inputMbtiButtonTitle: Observable<String?> = Observable(nil)
    var inputSuccessOrStoreButtonClicked: Observable<String?> = Observable(nil)
    var inputWithdrawalClicked: Observable<String?> = Observable(nil)
    
    var outputUserDefaultsData: Observable<(nickname: String?, profileName: String?, mbti: [String: Bool]?, isUser: Bool)> = Observable((nil, nil, nil, false))
    var outputValidationText = Observable("")
    var outputButtonValid = Observable(false)
    var outputNicknameValid = Observable(false)
    var outputMbtiButtonBool: Observable<[String: Bool]?> = Observable(nil)
    
    private let ud = UserDefaultsManager.shared
    private let repository = LikeListRepository.shared
    private let fileManager = ImageManager.shared
    
    private let mbtiSet: [String: String] = ["E": "I", "S": "N", "T": "F", "J": "P"]
    private var mbtiButtonBool: [String: Bool] = ["E": false, "I": false, "S": false, "N": false, "T": false, "F": false, "J": false, "P": false]
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            self?.setUserDefaultsData()
        }
        
        inputNickname.bind { [weak self] nickname in
            self?.validateNickname(nickname)
        }
        
        inputMbtiButtonTitle.bind { [weak self] buttonTitle in
            self?.mbtiButtonCheck(buttonTitle)
        }
        
        inputSuccessOrStoreButtonClicked.bind { [weak self] profileText in
            guard let profileText = profileText else {return}
            self?.successButtonClicked(profileText)
        }
        
        inputWithdrawalClicked.bind { [weak self] value in
            guard let _ = value else {return}
            self?.deleteAllData()
        }
    }
    
}
extension ProfileSettingViewModel{
    //MARK: - UserDefaults값 가져오기
    private func setUserDefaultsData() {
        let nickname = ud.nickname
        let profileName = ud.profileName
        let mbti = ud.mbti
        let isUser = ud.isUser
        mbtiButtonBool = mbti ?? mbtiButtonBool
        outputUserDefaultsData.value = (nickname, profileName, mbti, isUser)
        validateNickname(nickname)
        outputMbtiButtonBool.value = mbti
        updateOutputValid()
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
    
    //MARK: - 버튼 성공시
    private func successButtonClicked(_ profileText: String) {
        ud.nickname = inputNickname.value ?? "고래밥"
        ud.profileName = profileText
        ud.mbti = outputMbtiButtonBool.value ?? [:]
        ud.isUser = true
    }
    
    //MARK: - 회원탈퇴
    private func deleteAllData() {
        let allData = repository.fetchAll(value: true)
        
        for data in allData {
            fileManager.removeImageFromDocument(filename: data.photoID)
        }
        repository.deleteAll()
        ud.clearAllData()
    }
}
