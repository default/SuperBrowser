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
        default:
            return
        }
    }
}
