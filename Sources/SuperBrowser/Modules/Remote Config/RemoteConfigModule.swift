//
//  RemoteConfigModule.swift
//  
//
//  Created by Nikita Mikheev on 03.03.2022.
//

import Foundation
import UIKit

struct RemoteConfigModule {
    typealias View = UIViewController
    
    func build() -> View {
        guard let dataSource = SuperBrowser.shared.dataSource else {
            assertionFailure("Mising dataSource in shared instance")
            return UIViewController()
        }
        
        let presenter = ListPresenter(
            title: "Remote Config",
            dataSource: dataSource.remoteConfigListProvider
        )
        let controller = ListViewController<ListPresenter>(
            presenter: presenter
        )
        
        return controller
    }
}
