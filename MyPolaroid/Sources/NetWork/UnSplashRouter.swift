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
    case PhotoSearchAPI(query: String)
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
        case .PhotoStatisticsAPI(let photoID):
            return APIURL.photoStatistics + photoID + APIURL.photoStatisticsEndPointURL
        case .RandomPhotoAPI:
            return APIURL.randomPhoto
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .TopicPhotoAPI:
            return [
                UnSplashBody.page.rawValue: 1,
                UnSplashBody.orderBy.rawValue: "popular"
            ]
        case .PhotoSearchAPI(let query):
            return [
                UnSplashBody.page.rawValue: 1,
                UnSplashBody.perPage.rawValue: 20,
                UnSplashBody.orderBy.rawValue: "popular",
                UnSplashBody.color.rawValue: "yellow",
                UnSplashBody.lang.rawValue: "ko",
                UnSplashBody.query.rawValue: query
            ]
        case .PhotoStatisticsAPI, .RandomPhotoAPI:
            return nil
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var header: [String : String] {
        return [UnSplashHeader.authorization.rawValue: APIKey.unSplashClientID]
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
}

