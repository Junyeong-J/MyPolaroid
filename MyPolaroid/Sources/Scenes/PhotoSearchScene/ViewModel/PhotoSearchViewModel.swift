//
//  PhotoSearchViewModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/26/24.
//

import Foundation

final class PhotoSearchViewModel {
    
    var inputSearchButtonClicked: Observable<String?> = Observable(nil)
    
    var outputData: Observable<[PhotoSearch]> = Observable([])
    
    init() {
        transform()
    }
    
    private func transform() {
        inputSearchButtonClicked.bind { [weak self] word in
            self?.callRequest(word)
        }
    }
    
    private func callRequest(_ query: String?) {
        guard let query = query else { return }
        UnSplashAPIManager.shared.unSplashRequest(api: .PhotoSearchAPI(query: query), model: PhotoSearchResponse.self) { [weak self] result in
            switch result {
            case .success(let data):
                print("응답 데이터: \(data)")
                self?.outputData.value = data.results
            case .failure(let error):
                print("오류: \(error.localizedDescription)")
            }
        }
    }
    
}
