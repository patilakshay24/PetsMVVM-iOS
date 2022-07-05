//
//  PetsRepositoryProtocol.swift
//  PetsDummy
//
//  Created by Akshay Patil on 05/07/22.
//

import Foundation

protocol PetsRepositoryProtocol {
    func fetchConfigSettings(completion: @escaping (Result<[Pet], Error>) -> Void)
}
