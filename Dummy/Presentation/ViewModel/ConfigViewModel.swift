//
//  ConfigViewModel.swift
//  Dummy
//
//  Created by Akshay Patil on 27/06/22.
//

import Foundation

enum LoadingStatus {
    case loading
    case loadingDone
}

protocol ConfigViewModelInput {
    func viewDidLoad()
    func callButtonTapped()
    func chatButtonTapped()
}

protocol ConfigViewModelOutput {
    var configSettings: Observable<ConfigSettings> { get }
    var loading: Observable<LoadingStatus> { get }
    var error: Observable<String> { get }
    var alertMessage: Observable<String> { get }
}

class ConfigViewModel: ConfigViewModelInput, ConfigViewModelOutput {
    let configSettings: Observable<ConfigSettings> = Observable(ConfigSettings(false, false, ""))
    let loading: Observable<LoadingStatus> = Observable(.loading)
    let error: Observable<String> = Observable("")
    
    let alertMessage: Observable<String> = Observable("")
}

extension ConfigViewModel {
    func viewDidLoad() {
        loading.value = .loading
        let configSettingRepository = ConfigSettingsRepository()
        configSettingRepository.fetchConfigSettings { [weak self] result in
            self?.loading.value = .loadingDone
            do {
                self?.configSettings.value = try result.get()
            } catch {
                self?.error.value = error.localizedDescription
            }
        }
    }
    
    private func contactAlert() {
        if (configSettings.value.checkTimeIsInWorkHours()) {
            alertMessage.value = "Thank you for getting in touch with us. We'll get back to you as soon as possible"
        } else {
            alertMessage.value = "Work hours has ended. Please contact us again on the next work day"
        }
    }
    
    func callButtonTapped() {
        contactAlert()
    }
    
    func chatButtonTapped() {
        contactAlert()
    }
}

