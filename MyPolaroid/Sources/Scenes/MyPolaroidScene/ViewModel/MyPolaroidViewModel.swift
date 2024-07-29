//
//  MyPolaroidViewModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import Foundation

final class MyPolaroidViewModel {
    
    var inputTriggerViewWillAppear: Observable<Void?> = Observable(nil)
    var inputSortButtonClicked: Observable<Bool> = Observable(true)
    var inputLikeButtonClicked: Observable<String?> = Observable(nil)
    
    var outputPhotoData: Observable<[LikeListTable]> = Observable([])
    private let repository = LikeListRepository.shared
    private let fileManager = ImageManager.shared
    private var isSortLatest = true
    
    init() {
        transform()
    }
    
    private func transform() {
        inputTriggerViewWillAppear.bindAndFire { [weak self] _ in
            self?.fetchPhotoData(value: self?.isSortLatest ?? true)
        }
        
        inputSortButtonClicked.bindAndFire { [weak self] value in
            self?.isSortLatest = !value
            self?.fetchPhotoData(value: self?.isSortLatest ?? true)
        }
        
        inputLikeButtonClicked.bindAndFire { [weak self] photoID in
            guard let photoID = photoID else { return }
            self?.deleteData(photoID: photoID)
        }
    }
    
    private func fetchPhotoData(value: Bool) {
        let value = repository.fetchAll(value: value)
        outputPhotoData.value = Array(value)
    }
    
    private func deleteData(photoID: String) {
        if let existingItem = repository.fetchItem(photoID) {
            fileManager.removeImageFromDocument(filename: photoID)
            repository.deleteIdItem(existingItem)
            fetchPhotoData(value: isSortLatest)
        }
    }
}
