//
//  UnSplashAPIManager.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/24/24.
//

import Foundation
import Alamofire

final class UnSplashAPIManager {
    
    static let shared = UnSplashAPIManager()
    
    private init() { }
    
    typealias UnSplashHandler<T: Decodable> = (Result<T, Error>) -> Void
    
    func unSplashRequest<T: Decodable>(api: UnSplashRequest, model: T.Type, completionHandler: @escaping UnSplashHandler<T>) {
        AF.request(api.endPoint, method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString)
        )
        .validate(statusCode: 200..<500)
        .responseDecodable(of: model) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(error))
                print(error)
            }
        }
    }
    
}
