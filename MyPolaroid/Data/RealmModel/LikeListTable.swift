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
    @Persisted var favorite: Bool
    @Persisted var regdate: Date
    
    convenience init(photoID: String) {
        self.init()
        self.photoID = photoID
        self.favorite = true
    }
    
    override static func primaryKey() -> String? {
        return "photoID"
    }
}
