//
//  TopicPhotoModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/24/24.
//

import Foundation

struct TopicPhoto: Decodable {
    let id: String
    let created: String
    let width: Int
    let urls: TopicPhotoURLs
    let likes: Int
    let user: TopicPhotoUser
    
    enum CodingKeys: String, CodingKey {
        case id
        case created = "created_at"
        case width
        case urls
        case likes
        case user
    }
}

struct TopicPhotoURLs: Decodable {
    let raw: String
    let small: String
}

struct TopicPhotoUser: Decodable {
    let name: String
    let profileImage: TopicPhotoUserProfile
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "profile_image"
    }
}

struct TopicPhotoUserProfile: Decodable {
    let medium: String
}
