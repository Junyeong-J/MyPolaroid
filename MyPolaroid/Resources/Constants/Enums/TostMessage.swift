//
//  TostMessage.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/29/24.
//

import Foundation

enum TostMessage {
    case likeSuccess
    case likeCancel
    
    var message: String {
        switch self {
        case .likeSuccess:
            return "좋아요 성공"
        case .likeCancel:
            return "좋아요 취소"
        }
    }
}
