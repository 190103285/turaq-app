//
//  ProfilePresenter.swift
//  TuraqApp
//
//  Created by Akyl on 01.03.2023.
//

import UIKit

protocol ProfilePresentationLogic {
    func presentProfile(_ response: MenuModels.Initial.Response, _ isPushOn: Bool)
    func profilePresentationLogicLogouted()
    func receivedPermission(isPushOn: Bool)
}

final class ProfilePresenter: ProfilePresentationLogic {
    
    // MARK: - Public Properties
    
    weak var viewController: ProfileDisplayLogic?
    
    private var viewModel: ProfileModels.Initial.ViewModel?
    
    // MARK: - Presentation Logic
    
    func profilePresentationLogicLogouted() {
        viewController?.logouted()
    }
    
    func presentProfile(_ response: MenuModels.Initial.Response, _ isPushOn: Bool) {
        let viewModel = ProfileModels.Initial.ViewModel(sections: [
            buildProfileDataSection(phoneNumber: response.username),
            buildSettingsSection(isPushOn),
            buildLogoutSection(),
            buildDeleteAccountSection(model: response)
        ])
        self.viewModel = viewModel
        viewController?.presentProfile(viewModel)
    }
    
    func receivedPermission(isPushOn: Bool) {
        guard var viewModel else {
            return
        }
        viewModel.sections.remove(at: 1)
        viewModel.sections.insert(buildSettingsSection(isPushOn), at: 1)
        
        viewController?.presentProfile(viewModel)
    }
}

private extension ProfilePresenter {
    
    func buildProfileDataSection(phoneNumber: String) -> ProfileModels.Initial.ViewModel.SectionType {
        .profileData(title: "Your phone number".localized(), models: [
            .init(image: UIImage(named: "profile_phone_icon") ?? UIImage(), phoneNumber: phoneNumber)
        ])
    }
    
    func buildSettingsSection(_ isPushOn: Bool = false) -> ProfileModels.Initial.ViewModel.SectionType {
        return .settings(title: "Settings".localized(), models: [
            .init(settingsType: .language, isOn: true, name: "Change language".localized(), icon: UIImage(named: "language_icon") ?? UIImage()),
            .init(settingsType: .push, isOn: isPushOn, name: "Access to notifications".localized(), icon: UIImage(named: "notification_icon") ?? UIImage()),
            .init(settingsType: .location, isOn: PermissionsManager.isLocationPermissionEnabled(), name: "Access to geolocation".localized(), icon: UIImage(named: "pin_icon") ?? UIImage())
        ])
    }
    
    func buildDeleteAccountSection(model: MenuModels.Initial.Response) -> ProfileModels.Initial.ViewModel.SectionType {
        .deleteAccount(model: .init(userId: model.userId, title: "Delete account".localized(), typeImage: UIImage(named: "delete_icon") ?? UIImage()))
    }
    
    func buildLogoutSection() -> ProfileModels.Initial.ViewModel.SectionType {
        .logout(model: .init(title: "Log out".localized(), typeImage: UIImage(named: "logout_icon") ?? UIImage()))
    }
}
