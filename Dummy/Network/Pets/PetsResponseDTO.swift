//
//  PetsResponseDTO.swift
//  Dummy
//
//  Created by Akshay Patil on 27/06/22.
//

import Foundation

struct PetsResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case pets
    }
    let pets: [PetsListResponseDTO]
}

extension PetsResponseDTO {
    struct PetsListResponseDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case image_url
            case title
            case content_url
            case date_added
        }
        let image_url: String
        let title: String
        let content_url: String
        let date_added: String
    }
}
