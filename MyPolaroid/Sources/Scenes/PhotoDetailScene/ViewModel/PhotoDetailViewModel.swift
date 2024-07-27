//
//  PhotoDetailViewModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import Foundation

final class PhotoDetailViewModel {
    
    var inputViewDidLoadTrigger: Observable<String?> = Observable(nil)
    var inputHeartButtonClicked: Observable<Void?> = Observable(nil)
    
    var outputData: Observable<PhotoDetail?> = Observable(nil)
    var outputIsLiked: Observable<Bool> = Observable(false)
    
    private let repository = LikeListRepository.shared
    private let fileManager = ImageManager.shared
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { [weak self] id in
            guard let id = id else {return}
            self?.callRequset(id)
        }
        
        inputHeartButtonClicked.bind { [weak self] _ in
            self?.toggleLikeStatus()
        }
    }
    
    private func callRequset(_ id: String) {
        UnSplashAPIManager.shared.unSplashRequest(api: .PhotoDetailAPI(id: id), model: PhotoDetail.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.outputData.value = data
                self?.checkExistingItem(photoID: data.id)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func checkExistingItem(photoID: String) {
        let existingItem = repository.fetchItem(photoID)
        outputIsLiked.value = existingItem != nil
    }
    
    private func toggleLikeStatus() {
        guard let photoID = outputData.value?.id, let imageUrl = outputData.value?.urls.small else {
            return
        }
        
        if let existingItem = repository.fetchItem(photoID) {
            fileManager.removeImageFromDocument(filename: photoID)
            repository.deleteIdItem(existingItem)
            outputIsLiked.value = false
        } else {
            fileManager.saveImageFromURLToDocument(imageURL: imageUrl, filename: photoID)
            let likeItem = LikeListTable(photoID: photoID)
            repository.createItem(likeItem)
            outputIsLiked.value = true
        }
    }
    
}
