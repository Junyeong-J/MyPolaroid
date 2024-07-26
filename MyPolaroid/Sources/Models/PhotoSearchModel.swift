//
//  PhotoSearchModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/25/24.
//

import Foundation

struct PhotoSearchResponse: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoSearch]
}

struct PhotoSearch: Decodable {
    let id: String
    let created: String
    let width: Int
    let height: Int
    let urls: PhotoSearchURLs
    let likes: Int
    let user: PhotoSearchUser
    
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

struct PhotoSearchURLs: Decodable {
    let raw: String
    let small: String
}

struct PhotoSearchUser: Decodable {
    let name: String
    let profileImage: PhotoSearchUserProfile
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "profile_image"
    }
}

struct PhotoSearchUserProfile: Decodable {
    let medium: String
}
