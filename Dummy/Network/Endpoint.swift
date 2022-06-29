//
//  Endpoint.swift
//  Dummy
//
//  Created by Akshay Patil on 27/06/22.
//

import Foundation

public enum HTTPMethodType: String {
    case get = "GET"
}

public protocol Responsable {}

public class Endpoint {
    public let path: String
    public let method: HTTPMethodType
    
    init(path: String, method: HTTPMethodType = HTTPMethodType.get) {
        self.path = path
        self.method = method
    }
    
    public func urlRequest() throws -> URLRequest {
        let baseURL = "https://petsdummy.free.beeceptor.com/"
        let url = URL(string: baseURL + path)
        guard let url = url else { throw NetworkError.urlGeneration}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
    
    public func urlRequestWithoutBaseURL() throws -> URLRequest {
        let url = URL(string: path)
        guard let url = url else { throw NetworkError.urlGeneration}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }

}
