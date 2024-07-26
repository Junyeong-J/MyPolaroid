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
    
    var outputData: Observable<[PhotoSearch]> = Observable([])
    var outputCurrentPage = Observable(1)
    private var currentPage = 1
    private var currentQuery: String?
    
    init() {
        transform()
    }
    
    private func transform() {
        inputSearchButtonClicked.bind { [weak self] word in
            guard let word = word else { return }
            self?.currentQuery = word
            self?.currentPage = 1
            self?.outputData.value = []
            self?.callRequest(word, page: self?.currentPage ?? 1)
        }
        
        inputReCallPage.bind { [weak self] _ in
            self?.currentPage += 1
            self?.callRequest(self?.currentQuery ?? "", page: self?.currentPage ?? 1)
        }
    }
    
    private func callRequest(_ query: String, page: Int) {
        UnSplashAPIManager.shared.unSplashRequest(api: .PhotoSearchAPI(query: query, page: page), model: PhotoSearchResponse.self) { [weak self] result in
            switch result {
            case .success(let data):
//                self?.outputData.value = data.results
                self?.outputData.value.append(contentsOf: data.results)
                self?.outputCurrentPage.value = page
            case .failure(let error):
                print("오류: \(error.localizedDescription)")
            }
        }
    }
    
}
