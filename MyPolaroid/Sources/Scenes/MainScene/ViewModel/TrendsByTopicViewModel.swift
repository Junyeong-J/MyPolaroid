//
//  TrendsByTopicViewModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/24/24.
//

import Foundation

final class TrendsByTopicViewModel {
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    var outputData: Observable<[[String:[TopicPhoto]]]> = Observable([])
    
    init(){
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            self?.callRequests()
        }
    }
    
    private func callRequests() {
        let topicIDsArray = [TopicIDQuery.goldenHour, TopicIDQuery.architectureInterior, TopicIDQuery.businessWork]
        var photosByTopicArray: [[String: [TopicPhoto]]] = []
        let dispatchGroup = DispatchGroup()
        
        for topicID in topicIDsArray {
            dispatchGroup.enter()
            DispatchQueue.global().async(group: dispatchGroup) {
                UnSplashAPIManager.shared.unSplashRequest(api: .TopicPhotoAPI(topicID: topicID.rawValue), model: [TopicPhoto].self) { result in
                    switch result {
                    case .success(let data):
                        let fetchData: [String: [TopicPhoto]] = [topicID.displayTitle: data]
                        photosByTopicArray.append(fetchData)
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.outputData.value = photosByTopicArray
        }
    }
}
