//
//  LikeListTable.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import Foundation
import RealmSwift

class LikeListTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var photoID: String
    @Persisted var photoImageURL: String
    @Persisted var favorite: Bool
    @Persisted var regdate: Date
    @Persisted var authorProfile: String
    @Persisted var authorName: String
    @Persisted var postDate: String
    
    convenience init(photoID: String, photoImageURL: String, authorProfile: String, authorName: String, postDate: String) {
        self.init()
        self.photoID = photoID
        self.photoImageURL = photoImageURL
        self.favorite = true
        self.authorProfile = authorProfile
        self.authorName = authorName
        self.postDate = postDate
    }
    
    override static func primaryKey() -> String? {
        return "photoID"
    }
}
