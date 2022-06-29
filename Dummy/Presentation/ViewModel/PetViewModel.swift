//
//  PetViewModel.swift
//  Dummy
//
//  Created by Akshay Patil on 28/06/22.
//

import Foundation

protocol PetViewModelOutput {
}

protocol PetViewModelInput {
    var pet: Pet { get set }
}
class PetViewModel: PetViewModelInput,  PetViewModelOutput{
    public var pet: Pet
    
    init(_ pet: Pet) {
        self.pet = pet
    }
    
}
