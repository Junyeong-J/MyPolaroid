//
//  TargetType.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/26/24.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var header: [String: String] { get }
    var parameters: Parameters? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension TargetType {
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlComponents = URLComponents(url: url.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        
        guard let finalURL = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        var request = try URLRequest(url: finalURL, method: method)
        request.allHTTPHeaderFields = header
        request.httpBody = body
        return request
    }
    
}
