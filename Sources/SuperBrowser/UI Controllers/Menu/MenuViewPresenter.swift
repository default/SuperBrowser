//
//  MenuViewPresenter.swift
//  Created by Nikita Mikheev on 13.03.2022.
//

import Foundation

final class MenuViewPresenter {
    // MARK: Properties
    let controllerTitle: String?
    var sections: [MenuSection] {
        dataSource.sections
    }
    
    // MARK: Dependencies
    private let dataSource: MenuProviding
    private let router: ModuleRouting
    
    // MARK: Initializers
    init(
        title: String,
        dataSource: MenuProviding,
        router: ModuleRouting
    ) {
        self.controllerTitle = title
        self.dataSource = dataSource
        self.router = router
    }
}

// MARK: - MenuViewPresenting
extension MenuViewPresenter: MenuViewPresenting {
    func didUserSelect(item: MenuItemProtocol) {
        guard let destination = dataSource.destination(for: item) else {
            return
        }
        
        router.route(to: destination)
    }
}
