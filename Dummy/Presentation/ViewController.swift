//
//  ViewController.swift
//  Dummy
//
//  Created by Akshay Patil on 27/06/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var configViewModel: ConfigViewModel!
    private var petsViewModel: PetsViewModel!
    private var petViewModel: PetViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        configViewModel = ConfigViewModel()
        petsViewModel = PetsViewModel(actions: PetsListViewModelActions(showPetDetails: showPetDetails))
        
        bind(to: configViewModel)
        bind(to: petsViewModel)
        
        configViewModel.viewDidLoad()
        petsViewModel.viewDidLoad()
    }
    
    @IBAction func chatTapped(_ sender: Any) {
        configViewModel.chatButtonTapped()
    }
    
    @IBAction func callTapped(_ sender: Any) {
        configViewModel.callButtonTapped()
    }
    
    private func bind(to viewModel: ConfigViewModel) {
        viewModel.error.observe(on: self) { self.showError($0) }
        viewModel.loading.observe(on: self) { loadingStatus in
            if loadingStatus == .loading {
                self.timeLabel.text = "Loading..."
                self.callButton.isHidden = true
                self.chatButton.isHidden = true
                self.tableView.isHidden = true
            } else {
                self.timeLabel.text = ""
//                self.callButton.isHidden = false
//                self.chatButton.isHidden = false
                self.tableView.isHidden = false
            }
        }
        
        
        viewModel.configSettings.observe(on: self) { [weak self] value in
            self?.callButton.isHidden = !value.isCallEnabled
            self?.chatButton.isHidden = !value.isChatEnabled
            self?.timeLabel.text = value.workHours
        }
        
        viewModel.alertMessage.observe(on: self) { [weak self] value in
            if value != "" {
                self?.showAlert(message: value)
            }
        }
    }
    
    private func bind(to viewModel: PetsViewModel) {
        viewModel.loading.observe(on: self) { loadingStatus in
            self.tableView.reloadData()
        }
        
        viewModel.petsItemViewModel.observe(on: self) { _ in
            self.tableView.reloadData()
        }
    }

    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: "Error", message: error)
    }
    
    func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
    
    // MARK: to detail view
    private func showPetDetails(pet: Pet) {
        self.petViewModel = PetViewModel(pet)
        self.performSegue(withIdentifier: "detailedView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailedView" {
            let destVC : DetailedViewController = segue.destination as! DetailedViewController
               destVC.petViewModel = petViewModel
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petsViewModel.petsItemViewModel.value.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PetTableViewCell.reuseIdentifier, for: indexPath) as? PetTableViewCell else {
            return UITableViewCell()
        }
        let imageRepository = ImagesRepository()
        
        let petViewModel = petsViewModel.petsItemViewModel.value[indexPath.row]
        cell.fill(with: petViewModel, imageRepository: imageRepository)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        petsViewModel.didSelectItem(at: indexPath.row)
    }
    
}

