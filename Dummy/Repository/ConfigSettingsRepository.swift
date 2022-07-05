//
//  ConfigSettingsRepository.swift
//  Dummy
//
//  Created by Akshay Patil on 27/06/22.
//

import Foundation

/**
    fetchs config settings from cloud
 */
final class ConfigSettingsRepository: ConfigSettingsRepositoryProtocol {
    public func fetchConfigSettings(completion: @escaping (Result<ConfigSettings, Error>) -> Void) {
        let dataTransferService = DataTransferService()
        let requestDTO = ConfigRequestDTO()
        
        let endpoint = APIEndpoints.getConfigSettings(with: requestDTO)
        dataTransferService.request(with: endpoint) { result  in
            switch result {
            case .success(let responseDTO):
                let configResponse : ConfigSettingsResponseDTO? = try? JSONResponseDecoder<ConfigSettingsResponseDTO>().decode(responseDTO!)
                
                if let configResponse = configResponse {
                    let configSettings = ConfigSettings(configResponse.settings.isChatEnabled , configResponse.settings.isCallEnabled, configResponse.settings.workHours)
                    completion(.success(configSettings))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


