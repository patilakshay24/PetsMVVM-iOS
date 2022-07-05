//
//  ConfigSettingsRepositoryProtocol.swift
//  PetsDummy
//
//  Created by Akshay Patil on 05/07/22.
//

import Foundation

protocol ConfigSettingsRepositoryProtocol {
    func fetchConfigSettings(completion: @escaping (Result<ConfigSettings, Error>) -> Void)
}
