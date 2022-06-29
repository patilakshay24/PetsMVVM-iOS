//
//  ConfigResponseDTO.swift
//  Dummy
//
//  Created by Akshay Patil on 27/06/22.
//

import Foundation

struct ConfigSettingsResponseDTO : Decodable {
    private enum CodingKeys: String, CodingKey {
        case settings
    }
    let settings: SettingResponseDTO
}

extension ConfigSettingsResponseDTO {
    struct SettingResponseDTO : Decodable, Responsable {
        private enum CodingKeys: String, CodingKey {
            case isChatEnabled
            case isCallEnabled
            case workHours
        }
        let isChatEnabled: Bool
        let isCallEnabled: Bool
        let workHours: String
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            isChatEnabled = try values.decode(Bool.self, forKey: .isChatEnabled)
            isCallEnabled = try values.decode(Bool.self, forKey: .isCallEnabled)
            workHours = try values.decode(String.self, forKey: .workHours)
            
        }
    }
}
