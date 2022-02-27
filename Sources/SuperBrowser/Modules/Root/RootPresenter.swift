//
//  RootPresenter.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import Foundation

protocol RootRouting {
    func route(to: RootMenuItem)
}

final class RootPresenter: MenuViewPresenter {
    // MARK: Properties
    var items: [MenuItemProtocol] {
        RootMenuItem.allCases
    }
    
    // MARK: Dependencies
    private let router: RootRouting
    
    // MARK: Initializers
    init(router: RootRouting) {
        self.router = router
    }
}

// MARK: - MenuViewPresenter
extension RootPresenter: ViewDelegate {
    var controllerTitle: String? {
        "SuperBrowser"
    }
    
    func didUserSelect(item: MenuItemProtocol) {
        guard let item = item as? RootMenuItem else {
            assertionFailure("Unrecognized menu item selected")
            return
        }
        
        router.route(to: item)
    }
}
