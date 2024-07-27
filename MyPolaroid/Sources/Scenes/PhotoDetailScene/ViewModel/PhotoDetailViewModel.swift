//
//  PhotoDetailViewModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import Foundation

final class PhotoDetailViewModel {
    
    var inputViewDidLoadTrigger: Observable<String?> = Observable(nil)
    
    var outputData: Observable<PhotoDetail?> = Observable(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { [weak self] id in
            guard let id = id else {return}
            self?.callRequset(id)
        }
    }
    
    private func callRequset(_ id: String) {
        UnSplashAPIManager.shared.unSplashRequest(api: .PhotoDetailAPI(id: id), model: PhotoDetail.self) { [weak self] result in
            switch result {
            case .success(let data):
                print(data)
                self?.outputData.value = data
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
