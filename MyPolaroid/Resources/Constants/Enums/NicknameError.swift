//
//  NicknameError.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/24/24.
//

import Foundation

//MARK: - 닉네임 에러
enum NicknameError: Error {
    case characterError(String)
    case count
    case correct
    case ect
    
    var eachError: String{
        switch self {
        case .characterError(let character):
            return "닉네임에 \(character)는 포함할 수 없어요"
        case .count:
            return "2글자 이상 10글자 미만으로 설정해주세요"
        case .correct:
            return "사용할 수 있는 닉네임이에요"
        case .ect:
            return ""
        }
    }
}
