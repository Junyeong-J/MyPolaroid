//
//  RandomPhotoModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/25/24.
//

import Foundation

struct RandomPhoto: Decodable {
    let id: String
    let created: String
    let width: Int
    let height: Int
    let urls: RandomPhotoURLs
    let likes: Int
    let user: RandomPhotoUser
    
    enum CodingKeys: String, CodingKey {
        case id
        case created = "created_at"
        case width
        case height
        case urls
        case likes
        case user
    }
}

struct RandomPhotoURLs: Decodable {
    let row: String
}

struct RandomPhotoUser: Decodable {
    let name: String
    let profileImage: RandomPhotoUserProfile
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "profile_image"
    }
}

struct RandomPhotoUserProfile: Decodable {
    let medium: String
}
