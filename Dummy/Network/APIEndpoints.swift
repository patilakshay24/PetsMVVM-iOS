//
//  APIEndpoints.swift
//  Dummy
//
//  Created by Akshay Patil on 27/06/22.
//

import Foundation

struct APIEndpoints {
    static func getConfigSettings(with configRequestDTO: ConfigRequestDTO) -> Endpoint {
        return Endpoint(path: "configSettings",
                        method: .get)
    }
    
    static func getPets(with petsRequest: PetsRequestDTO) -> Endpoint {
        return Endpoint(path: "pets",
                        method: .get)
    }
    
    static func getImage(with imagePath: String) -> Endpoint {
        return Endpoint(path: imagePath,
                        method: .get)
    }
}
