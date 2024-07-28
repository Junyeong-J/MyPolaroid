//
//  UserDefaultsManager.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/26/24.
//

import Foundation

final class UserDefaultsManager {
    
    private enum UserDefaultsKey: String {
        case profileForKey = "profileName"
        case nicknameForKey = "nickname"
        case mbtiForKey = "MBTI"
        case user = "isUser"
    }
    
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    //MARK: - 프로필
    var profileName: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKey.profileForKey.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.profileForKey.rawValue)
        }
    }
    
    //MARK: - 닉네임
    var nickname: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKey.nicknameForKey.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.nicknameForKey.rawValue)
        }
    }
    
    //MARK: - MBTI
    var mbti: [String: Bool]? {
        get {
            return UserDefaults.standard.dictionary(forKey: UserDefaultsKey.mbtiForKey.rawValue) as? [String: Bool]
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.mbtiForKey.rawValue)
        }
    }
    
    
    //MARK: - 사용자
    var isUser: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultsKey.user.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.user.rawValue)
        }
    }
    
    //MARK: - UserDefaults값 모두 삭제
    func clearAllData() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
}
