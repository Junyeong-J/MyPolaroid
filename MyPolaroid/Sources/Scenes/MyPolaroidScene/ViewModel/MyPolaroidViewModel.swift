//
//  MyPolaroidViewModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import Foundation

final class MyPolaroidViewModel {
    
    var inputTriggerViewWillAppear: Observable<Void?> = Observable(nil)
    
    var outputPhotoData: Observable<[LikeListTable]> = Observable([])
    private let repository = LikeListRepository.shared
    
    init() {
        transform()
    }
    
    private func transform() {
        inputTriggerViewWillAppear.bind { [weak self] _ in
            self?.fetchPhotoData()
        }
    }
    
    private func fetchPhotoData() {
        let value = repository.fetchAll()
        outputPhotoData.value = Array(value)
    }
    
}
