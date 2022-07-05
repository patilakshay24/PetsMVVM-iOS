//
//  ImagesRepository.swift
//  Dummy
//
//  Created by Akshay Patil on 28/06/22.
//

import Foundation

class ImagesRepository {
    public func fetchImage(_ imagePath: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        let endpoint = APIEndpoints.getImage(with: imagePath)
        DataTransferService().requestImage(with: endpoint) { (result: Result<Data?, NetworkError>) in

            let result = result.mapError { $0 as Error }
            DispatchQueue.main.async { completion(result) }
        }
    }
}


public class RawDataResponseDecoder<T: Decodable> {
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case `default` = ""
    }
    public func decode(_ data: Data) throws -> T {
        if T.self is Data.Type, let data = data as? T {
            return data
        } else {
            let context = DecodingError.Context(codingPath: [CodingKeys.default], debugDescription: "Expected Data type")
            throw Swift.DecodingError.typeMismatch(T.self, context)
        }
    }
}
