//
//  TrendsByTopicViewModel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/24/24.
//

import Foundation

final class TrendsByTopicViewModel {
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    
    var outputData: Observable<[[String:[TopicPhoto]]]> = Observable([])
    var outputProfile: Observable<String?> = Observable(nil)
    private let ud = UserDefaultsManager.shared
    
    init(){
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            self?.callRequests()
        }
        
        inputViewWillAppearTrigger.bind { [weak self] _ in
            self?.setProfile()
        }
    }
    
    private func callRequests() {
        let topicIDsArray: [TopicIDQuery] = [.goldenHour, .architectureInterior, .businessWork]
        var photosByTopicArray: [[String: [TopicPhoto]]] = []
        let dispatchGroup = DispatchGroup()
        
        for topicID in topicIDsArray {
            dispatchGroup.enter()
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
        
        dispatchGroup.notify(queue: .main) {
            self.outputData.value = photosByTopicArray
        }
    }
    
    private func setProfile() {
        let profileName = ud.profileName
        outputProfile.value = profileName
    }
}
