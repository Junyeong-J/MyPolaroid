//
//  PhotoDetailModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import Foundation

struct PhotoDetail: Decodable {
    let id: String
    let created: String
    let width: Int
    let height: Int
    let urls: PhotoDetailURLs
    let likes: Int
    let user: PhotoDetailUser
    let views: Int
    let downloads: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case created = "created_at"
        case width
        case height
        case urls
        case likes
        case user
        case views
        case downloads
    }
}

struct PhotoDetailURLs: Decodable {
    let raw: String
    let small: String
}

struct PhotoDetailUser: Decodable {
    let name: String
    let profileImage: PhotoDetailUserProfile
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "profile_image"
    }
}

struct PhotoDetailUserProfile: Decodable {
    let medium: String
}
