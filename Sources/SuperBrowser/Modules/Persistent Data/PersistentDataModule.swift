//
//  PersistentDataModule.swift
//  Created by Nikita Mikheev on 28.02.2022.
//

import Foundation
import UIKit

struct PersistentDataModule {
    typealias View = UIViewController
    
    func build() -> View {
        guard let dataSource = SuperBrowser.shared.dataSource else {
            assertionFailure("Mising dataSource in shared instance")
            return UIViewController()
        }
        
        let presenter = ListPresenter(
            title: "Persistent Data",
            dataSource: dataSource.persistentDataListProvider
        )
        let controller = ListViewController<ListPresenter>(
            presenter: presenter
        )
        
        return controller
    }
}
