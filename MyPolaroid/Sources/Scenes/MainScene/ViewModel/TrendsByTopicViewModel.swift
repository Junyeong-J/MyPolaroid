//
//  TrendsByTopicViewModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/24/24.
//

import Foundation

final class TrendsByTopicViewModel {
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    var outputData: Observable<[TopicPhoto]> = Observable([])
    
    init(){
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            self?.callRequest()
        }
    }
    
    private func callRequest() {
        UnSplashAPIManager.shared.unSplashRequest(api: .TopicPhotoAPI(topicID: TopicIDQuery.goldenHour.rawValue), model: [TopicPhoto].self) { [weak self] result in
            switch result {
            case .success(let data):
                print(data)
                self?.outputData.value = data
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
