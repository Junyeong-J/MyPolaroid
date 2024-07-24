//
//  UnSplashRequest.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/24/24.
//

import Foundation
import Alamofire

enum UnSplashRequest {
    
    case TopicPhotoAPI(topicID: String)
    case PhotoSearchAPI
    case PhotoStatisticsAPI
    case RandomPhotoAPI
    
    var baseURL: String{
        return APIURL.unSplashBaseURL
    }
    
    var endPoint: URL {
        guard let url = URL(string: baseURL) else {
            fatalError("Invalid URL: \(baseURL)")
        }
        switch self {
        case .TopicPhotoAPI(let topicID):
            guard let url = URL(string: baseURL + topicID + APIURL.topicPhotoEndPointURL) else {
                fatalError("Invalid URL: \(baseURL)")
            }
            return url
        case .PhotoSearchAPI:
            return url
        case .PhotoStatisticsAPI:
            return url
        case .RandomPhotoAPI:
            return url
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .TopicPhotoAPI(_):
            return [
                "page" : 1,
                "order_by" : "popular",
                "client_id": APIKey.unSplashClientID
            ]
        case .PhotoSearchAPI, .PhotoStatisticsAPI, .RandomPhotoAPI:
            return [:]
        }
        
    }
}
