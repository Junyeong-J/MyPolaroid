//
//  PhotoSearchViewModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/26/24.
//

import Foundation

final class PhotoSearchViewModel {
    
    var inputSearchButtonClicked: Observable<String?> = Observable(nil)
    var inputReCallPage: Observable<Void?> = Observable(nil)
    var inputLikeButtonClicked: Observable<String?> = Observable(nil)
    var inputSortButtonClicked: Observable<Bool> = Observable(false)
    
    var outputData: Observable<[PhotoSearch]> = Observable([])
    var outputCurrentPage = Observable(1)
    var outputIsLiked: Observable<Bool> = Observable(false)
    private let repository = LikeListRepository.shared
    private let fileManager = ImageManager.shared
    private var currentPage = 1
    private var currentQuery: String?
    private var orderBy: String = "relevant"
    
    init() {
        transform()
    }
    
    private func transform() {
        inputSearchButtonClicked.bindAndFire { [weak self] word in
            guard let word = word else { return }
            self?.currentQuery = word
            self?.currentPage = 1
            self?.outputData.value = []
            self?.callRequest(word, page: self?.currentPage ?? 1, orderBy: self?.orderBy ?? "relevant")
        }
        
        inputReCallPage.bindAndFire { [weak self] _ in
            self?.currentPage += 1
            self?.callRequest(self?.currentQuery ?? "", page: self?.currentPage ?? 1, orderBy: self?.orderBy ?? "relevant")
        }
        
        inputSortButtonClicked.bindAndFire { [weak self] value in
            self?.orderBy = value ? "latest" : "relevant"
            guard let query = self?.currentQuery else { return }
            self?.outputData.value = []
            self?.currentPage = 1
            self?.callRequest(query, page: self?.currentPage ?? 1, orderBy: self?.orderBy ?? "latest")
        }
        
        inputLikeButtonClicked.bindAndFire { [weak self] photoID in
            guard let photoID = photoID else {return}
            self?.toggleLikeStatus(photoID)
        }
    }
    
    private func callRequest(_ query: String, page: Int, orderBy: String) {
        UnSplashAPIManager.shared.unSplashRequest(api: .PhotoSearchAPI(query: query, page: page, orderBy: orderBy), model: PhotoSearchResponse.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.outputData.value.append(contentsOf: data.results)
                self?.outputCurrentPage.value = page
            case .failure(let error):
                print("오류: \(error.localizedDescription)")
            }
        }
    }
    
    private func toggleLikeStatus(_ photoID: String) {
        guard let photoData = outputData.value.first(where: { $0.id == photoID }) else { return }
        let imageUrl = photoData.urls.small
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
