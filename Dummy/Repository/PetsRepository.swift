//
//  PetsRepository.swift
//  Dummy
//
//  Created by Akshay Patil on 27/06/22.
//

import Foundation

/**
    fetchs pets json from cloud
 */
final class PetsRepository: PetsRepositoryProtocol {
    public func fetchConfigSettings(completion: @escaping (Result<[Pet], Error>) -> Void) {
        let dataTransferService = DataTransferService()
        let requestDTO = PetsRequestDTO()
        
        let endpoint = APIEndpoints.getPets(with: requestDTO)
        dataTransferService.request(with: endpoint) { result  in
            switch result {
            case .success(let responseDTO):
                let petsResponse : PetsResponseDTO? = try? JSONResponseDecoder<PetsResponseDTO>().decode(responseDTO!)
                var mPets : [Pet] = []
                if let petsResponse = petsResponse {
                    for singlePet in petsResponse.pets {
                        mPets.append(Pet(singlePet.image_url, singlePet.title, singlePet.content_url, singlePet.date_added))
                    }
                }
                completion(.success(mPets))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
