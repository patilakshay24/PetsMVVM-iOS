//
//  PetsViewModel.swift
//  Dummy
//
//  Created by Akshay Patil on 28/06/22.
//

import Foundation

enum PetsLoadingStatus {
    case PetsLoading
    case PetsLoadingDone
}

struct PetsListViewModelActions {
    let showPetDetails: (Pet) -> Void
}
protocol PetsViewModelOutput {
    var pets : [Pet] { get }
    var petsItemViewModel: Observable<[PetItemViewModel]> { get }
    var loading: Observable<PetsLoadingStatus> { get }
}

protocol PetsViewModelInput {
    func viewDidLoad()
    func didSelectItem(at index: Int)
//    func loadImage()
}


class PetsViewModel: PetsViewModelInput, PetsViewModelOutput {
    private let actions: PetsListViewModelActions?
    
    var pets: [Pet] = []
    
    let petsItemViewModel: Observable<[PetItemViewModel]> = Observable([])
    let loading: Observable<PetsLoadingStatus> = Observable(.PetsLoading)
    
    init(actions: PetsListViewModelActions? = nil) {
        self.actions = actions
    }
    
}

extension PetsViewModel {
    func viewDidLoad() {
        loading.value = .PetsLoading
        let petRepository = PetsRepository()
        petRepository.fetchConfigSettings { [weak self] result in
            do {
                self?.pets = try result.get()
                if let mPets = self?.pets {
                    self?.loading.value = .PetsLoadingDone
                    self?.petsItemViewModel.value = mPets.map( PetItemViewModel.init )
                }
            } catch {
                
            }
        }
    }
    
    func didSelectItem(at index: Int) {
        self.actions?.showPetDetails(self.pets[index])
    }
}

