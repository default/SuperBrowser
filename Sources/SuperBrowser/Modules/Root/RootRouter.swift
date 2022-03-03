//
//  RootRouter.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import UIKit

final class RootRouter {
    // MARK: Properties
    weak var viewController: UIViewController?
    
    // MARK: Navigation
    private func routeToSystem() {
        viewController?.navigationController?.pushViewController(
            SystemModule().build(), animated: true
        )
    }
    private func routeToRemoteConfig() {
        viewController?.navigationController?.pushViewController(
            RemoteConfigModule().build(), animated: true
        )
    }
    private func routeToPersistentData() {
        viewController?.navigationController?.pushViewController(
            PersistentDataModule().build(), animated: true
        )
    }
}

// MARK: - RootRouting
extension RootRouter: RootRouting {
    func route(to item: RootMenuItem) {
        guard viewController != nil else {
            assertionFailure("UIViewController not connected to router")
            return
        }
        
        switch item {
        case .system:
            routeToSystem()
        case .remoteConfig:
            routeToRemoteConfig()
        case .persistentData:
            routeToPersistentData()
        default:
            return
        }
    }
}
