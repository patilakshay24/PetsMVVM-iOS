//
//  DatatransferService.swift
//  Dummy
//
//  Created by Akshay Patil on 28/06/22.
//

import Foundation

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case generic(Error)
    case urlGeneration
}

final class DataTransferService {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    
    private func request(_ request: URLRequest,
                        completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
    
    private func requestImage(_ request: URLRequest,
                              completion: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {
        let task = URLSession.shared.downloadTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
    

    private func request(request: URLRequest, completion: @escaping CompletionHandler) {
        
        _ = self.request(request) { data, response, requestError in
            
            if let requestError = requestError {
                var error: NetworkError
                error = self.resolve(error: requestError)
                completion(.failure(error))
            } else if let response = response as? HTTPURLResponse {
                var error: NetworkError
                if response.statusCode == 200 {
                    completion(.success(data))
                } else {
                    error = .error(statusCode: response.statusCode, data: data)
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func requestImage(request: URLRequest, completion: @escaping CompletionHandler) {
        
        _ = self.requestImage(request) { url, response, requestError in
            
            if let requestError = requestError {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    error = .error(statusCode: response.statusCode, data: nil)
                } else {
                    error = self.resolve(error: requestError)
                }
                
                completion(.failure(error))
            } else {
                if let temUrl = url {
                    let data = try? Data(contentsOf: temUrl, options: [.mappedIfSafe])
                    completion(.success(data))
                }
            }
        }
    }

    public func request(with endpoint: Endpoint, completion: @escaping CompletionHandler) {
        return request(request: try! endpoint.urlRequest()) { result in
            switch result {
            case .success:
                DispatchQueue.main.async { return completion(result) }
            case .failure(let error):
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
    }
    
    public func requestImage(with endpoint: Endpoint, completion: @escaping CompletionHandler) {
        return requestImage(request: try! endpoint.urlRequestWithoutBaseURL()) { result in
            switch result {
            case .success:
                DispatchQueue.main.async { return completion(result) }
            case .failure(let error):
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        default: return .generic(error)
        }
    }
}
