//
//  NavigationTitle.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/26/24.
//

import Foundation

enum NavigationTitle {
    case profileSetting
    case ourTopic
    case searchPhoto
    case myPolaroid
    case editProfile
    
    var title: String {
        switch self {
        case .profileSetting:
            return "PROFILE SETTING"
        case .ourTopic:
            return "OUR TOPIC"
        case .searchPhoto:
            return "SEARCH PHOTO"
        case .myPolaroid:
            return "MY POLAROID"
        case .editProfile:
            return "EDIT PROFILE"
        }
    }
}
