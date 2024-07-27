//
//  UnSplashRequest.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/24/24.
//

import Foundation
import Alamofire

enum UnSplashRouter {
    
    case TopicPhotoAPI(topicID: String)
    case PhotoSearchAPI(query: String, page: Int)
    case PhotoDetailAPI(id: String)
    case PhotoStatisticsAPI(photoID: String)
    case RandomPhotoAPI
}

extension UnSplashRouter: TargetType {
    
    var baseURL: String{
        return APIURL.unSplashBaseURL
    }
    
    var path: String {
        switch self {
        case .TopicPhotoAPI(let topicID):
            return APIURL.topicPhoto + topicID + APIURL.topicPhotoEndPointURL
        case .PhotoSearchAPI:
            return APIURL.photoSearch
        case .PhotoDetailAPI(let id):
            return APIURL.photoStatistics + id
        case .PhotoStatisticsAPI(let photoID):
            return APIURL.photoStatistics + photoID + APIURL.photoStatisticsEndPointURL
        case .RandomPhotoAPI:
            return APIURL.randomPhoto
        }
    }
    
    var parameters: Alamofire.Parameters? {
        return nil
        
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var header: [String : String] {
        return [UnSplashHeader.authorization.rawValue: APIKey.unSplashClientID]
    }
    
    var queryItems: [URLQueryItem]? {
        
        switch self {
        case .TopicPhotoAPI(_):
            return [
                URLQueryItem(name: UnSplashBody.page.rawValue, value: "1"),
                URLQueryItem(name: UnSplashBody.orderBy.rawValue, value: "popular")
            ]
        case .PhotoSearchAPI(let query, let page):
            return [
                URLQueryItem(name: UnSplashBody.page.rawValue, value: "\(page)"),
                URLQueryItem(name: UnSplashBody.perPage.rawValue, value: "20"),
                URLQueryItem(name: UnSplashBody.orderBy.rawValue, value: "latest"),
                URLQueryItem(name: UnSplashBody.color.rawValue, value: "yellow"),
                URLQueryItem(name: UnSplashBody.lang.rawValue, value: "ko"),
                URLQueryItem(name: UnSplashBody.query.rawValue, value: query)
            ]
        case .PhotoDetailAPI, .PhotoStatisticsAPI, .RandomPhotoAPI:
            return nil
        }
        
        
    }
    
    var body: Data? {
        return nil
    }
}
