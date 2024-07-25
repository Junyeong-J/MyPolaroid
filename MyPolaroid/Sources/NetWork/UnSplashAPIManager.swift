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
    
    func unSplashRequest<T: Decodable>(api: UnSplashRouter, model: T.Type, completionHandler: @escaping UnSplashHandler<T>) {
        do {
            let request = try api.asURLRequest()
            AF.request(request)
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
        } catch {
            print(error)
            completionHandler(.failure(error))
        }
    }
}
