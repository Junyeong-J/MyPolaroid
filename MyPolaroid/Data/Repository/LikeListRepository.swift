//
//  LikeListRepository.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import Foundation
import RealmSwift

final class LikeListRepository {
    
    static let shared = LikeListRepository()
    private init() { }
    
    private let realm = try! Realm()
    
    func detectRealmURL() {
        print(realm.configuration.fileURL ?? "")
    }
    
    func fetchItem(_ photoID: String) -> LikeListTable? {
        return realm.objects(LikeListTable.self).filter("photoID == %@", photoID).first
    }
    
    func fetchAll() -> Results<LikeListTable> {
        return realm.objects(LikeListTable.self).sorted(byKeyPath: "regdate", ascending: false)
    }
    
    func createItem(_ data: LikeListTable) {
        do {
            try realm.write {
                realm.add(data)
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm Error")
        }
    }
    
    func deleteIdItem(_ item: LikeListTable) {
        if let objectToDelete = realm.object(ofType: LikeListTable.self, forPrimaryKey: item.photoID) {
            do {
                try realm.write {
                    realm.delete(objectToDelete)
                    print("Realm Delete Succeed")
                }
            } catch {
                print("Realm Delete Error")
            }
        } else {
            print("Item not found")
        }
    }
    
}
