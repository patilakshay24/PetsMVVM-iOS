//
//  JSONResponseDecoder.swift
//  Dummy
//
//  Created by Akshay Patil on 28/06/22.
//

import Foundation


// MARK: - Response Decoders
public class JSONResponseDecoder<T: Decodable> {
    private let jsonDecoder = JSONDecoder()
    public init() { }
    public func decode(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
