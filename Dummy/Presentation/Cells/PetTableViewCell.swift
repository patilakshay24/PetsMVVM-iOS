//
//  PetTableViewCell.swift
//  Dummy
//
//  Created by Akshay Patil on 28/06/22.
//

import UIKit

class PetTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var petImageView: UIImageView!
    
    static let reuseIdentifier = String(describing: PetTableViewCell.self)
    
    private var viewModel: PetItemViewModel!
    private var imageRepository: ImagesRepository?
    
    func fill(with viewModel: PetItemViewModel, imageRepository: ImagesRepository?) {
        self.viewModel = viewModel
        self.imageRepository = imageRepository

        titleLabel.text = viewModel.title
        loadImage()
    }
    
    func loadImage() {
        imageRepository?.fetchImage(viewModel.image_url) { result in
            if case let .success(data) = result {
                let img: UIImage? = UIImage(data: data!)
                self.petImageView.image = UIImage(data: data!)
            }
        }
    }
    
}
