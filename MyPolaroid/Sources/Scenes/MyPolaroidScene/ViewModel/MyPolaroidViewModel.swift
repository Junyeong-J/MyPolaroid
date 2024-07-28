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
    
    var outputPhotoData: Observable<[LikeListTable]> = Observable([])
    private let repository = LikeListRepository.shared
    
    init() {
        transform()
    }
    
    private func transform() {
        inputTriggerViewWillAppear.bind { [weak self] _ in
            self?.fetchPhotoData(value: false)
        }
        
        inputSortButtonClicked.bind { [weak self] value in
            self?.fetchPhotoData(value: value)
        }
    }
    
    private func fetchPhotoData(value: Bool) {
        let value = repository.fetchAll(value: value)
        outputPhotoData.value = Array(value)
    }
    
}
