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
    var outputTextErrorMessage: Observable<String?> = Observable(nil)
    var outputCurrentPage = Observable(1)
    var outputIsLiked: Observable<Bool> = Observable(false)
    var outputTostMessage: Observable<String?> = Observable(nil)
    
    private let repository = LikeListRepository.shared
    private let fileManager = ImageManager.shared
    private var currentPage = 1
    private var currentQuery: String?
    private var orderBy: String = "relevant"
    
    init() {
        transform()
    }
    
    private func transform() {
        inputSearchButtonClicked.bind { [weak self] word in
            guard let word = word else { return }
            do {
                try self?.validateUserInput(text: word)
                self?.currentQuery = word
                self?.currentPage = 1
                self?.outputData.value = []
                self?.callRequest(word, page: self?.currentPage ?? 1, orderBy: self?.orderBy ?? "relevant")
            } catch ValidationError.emptyString {
                self?.outputTextErrorMessage.value = "검색어를 입력하세요"
            } catch ValidationError.trimmingCharacters {
                self?.outputTextErrorMessage.value = "공백만 검색이 안됩니다"
            } catch {
                self?.outputTextErrorMessage.value = "검색어 문제입니다."
            }
        }
        
        inputReCallPage.bind { [weak self] _ in
            self?.currentPage += 1
            self?.callRequest(self?.currentQuery ?? "", page: self?.currentPage ?? 1, orderBy: self?.orderBy ?? "relevant")
        }
        
        inputSortButtonClicked.bind { [weak self] value in
            self?.orderBy = value ? "latest" : "relevant"
            guard let query = self?.currentQuery else { return }
            self?.outputData.value = []
            self?.currentPage = 1
            self?.callRequest(query, page: self?.currentPage ?? 1, orderBy: self?.orderBy ?? "latest")
        }
        
        inputLikeButtonClicked.bind { [weak self] photoID in
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
            outputTostMessage.value = TostMessage.likeCancel.message
        } else {
            fileManager.saveImageFromURLToDocument(imageURL: imageUrl, filename: photoID)
            let likeItem = LikeListTable(photoID: photoID)
            repository.createItem(likeItem)
            outputIsLiked.value = true
            outputTostMessage.value = TostMessage.likeSuccess.message
        }
    }
    
    private func validateUserInput(text: String?) throws {
        guard let text = text, !text.isEmpty else {
            throw ValidationError.emptyString
        }
        guard !isOnlyWhitespace(text: text) else {
            throw ValidationError.trimmingCharacters
        }
    }
    
    private func isOnlyWhitespace(text: String) -> Bool {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
