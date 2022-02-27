//
//  SystemModule.swift
//  Created by Nikita Mikheev on 28.02.2022.
//

import Foundation
import UIKit

struct SystemModule {
    typealias View = UIViewController
    
    // MARK: Factories
    func build() -> View {
        guard let dataSource = SuperBrowser.shared.dataSource else {
            assertionFailure("Mising dataSource in shared instance")
            return UIViewController()
        }
        
        let presenter = SystemPresenter(
            dataSource: dataSource.systemListProvider
        )
        let controller = ListViewController<SystemPresenter>(
            presenter: presenter
        )
        
        return controller
    }
}
