//
//  PetItemViewModel.swift
//  Dummy
//
//  Created by Akshay Patil on 28/06/22.
//

import Foundation


class PetItemViewModel {
    let title : String
    let image_url: String
    
    init(_ pet: Pet) {
        self.title = pet.title
        self.image_url = pet.image_url
    }
}
