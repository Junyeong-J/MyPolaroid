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
        inputViewDidLoadTrigger.bindAndFire { [weak self] id in
            guard let id = id else {return}
            self?.callRequset(id)
            self?.loadLocalData(id: id)
        }
        
        inputHeartButtonClicked.bindAndFire { [weak self] _ in
            self?.toggleLikeStatus()
        }
    }
    
    private func callRequset(_ id: String) {
        UnSplashAPIManager.shared.unSplashRequest(api: .PhotoDetailAPI(id: id), model: PhotoDetail.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.checkExistingItem(data: data)
            case .failure(let error):
                print(error)
                self?.loadLocalData(id: id)
            }
        }
    }
    
    private func loadLocalData(id: String) {
        if let existingItem = repository.fetchItem(id) {
            let photoData = PhotoDetail(
                id: existingItem.photoID,
                created: existingItem.postDate,
                width: 0,
                height: 0,
                urls: PhotoDetailURLs(raw: "", small: existingItem.photoImageURL),
                likes: 0,
                user: PhotoDetailUser(
                    name: existingItem.authorName,
                    profileImage: PhotoDetailUserProfile(medium: existingItem.authorProfile)
                ),
                views: 0,
                downloads: 0
            )
            self.outputData.value = photoData
            outputIsLiked.value = true
        } else {
            outputData.value = nil
            outputIsLiked.value = false
        }
    }
    
    private func checkExistingItem(data: PhotoDetail) {
        if let existingItem = repository.fetchItem(data.id) {
            let photoData = PhotoDetail(
                id: existingItem.photoID,
                created: existingItem.postDate,
                width: data.width,
                height: data.height,
                urls: PhotoDetailURLs(raw: data.urls.raw, small: existingItem.photoImageURL),
                likes: data.likes,
                user: PhotoDetailUser(
                    name: existingItem.authorName,
                    profileImage: PhotoDetailUserProfile(medium: existingItem.authorProfile)
                ),
                views: data.views,
                downloads: data.downloads
            )
            outputIsLiked.value = true
            self.outputData.value = photoData
        } else {
            self.outputData.value = data
            outputIsLiked.value = false
        }
    }
    
    private func toggleLikeStatus() {
        guard let photoDetail = outputData.value, let photoID = outputData.value?.id, let imageUrl = outputData.value?.urls.small else {
            return
        }
        
        if let existingItem = repository.fetchItem(photoID) {
            fileManager.removeImageFromDocument(filename: photoID)
            fileManager.removeImageFromDocument(filename: photoID + photoDetail.user.name)
            repository.deleteIdItem(existingItem)
            outputIsLiked.value = false
        } else {
            fileManager.saveImageFromURLToDocument(imageURL: imageUrl, filename: photoID)
            fileManager.saveImageFromURLToDocument(imageURL: photoDetail.user.profileImage.medium, filename: photoID + photoDetail.user.name)
            let likeItem = LikeListTable(photoID: photoDetail.id, photoImageURL: imageUrl, authorProfile: photoDetail.user.profileImage.medium, authorName: photoDetail.user.name, postDate: photoDetail.created)
            repository.createItem(likeItem)
            outputIsLiked.value = true
        }
    }
    
}
