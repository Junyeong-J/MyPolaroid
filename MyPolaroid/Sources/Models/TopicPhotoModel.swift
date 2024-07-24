//
//  TopicPhotoModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/24/24.
//

import Foundation

struct TopicPhoto: Decodable {
    let id: String
    let created_at: String
    let width: Int
    let urls: TopicPhotoURLs
    let likes: Int
    let user: TopicPhotoUser
}

struct TopicPhotoURLs: Decodable {
    let raw: String
    let small: String
}

struct TopicPhotoUser: Decodable {
    let name: String
    let profile_image: TopicPhotoUserProfile
}

struct TopicPhotoUserProfile: Decodable {
    let medium: String
}
