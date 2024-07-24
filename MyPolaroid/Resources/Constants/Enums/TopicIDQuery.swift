//
//  TopicIDQuery.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/24/24.
//

import Foundation

enum TopicIDQuery: String {
    case goldenHour = "golden-hour"
    case architectureInterior = "architecture-interior"
    case businessWork = "business-work"
    
    var displayTitle: String{
        switch self {
        case .goldenHour:
            return "골든 아워"
        case .architectureInterior:
            return "비즈니스 및 업무"
        case .businessWork:
            return "건축 및 인테리어"
        }
    }
}
