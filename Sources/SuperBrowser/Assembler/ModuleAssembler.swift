//
//  ModuleAssembler.swift
//  Created by Nikita Mikheev on 13.03.2022.
//

import UIKit

struct ModuleAssembler {
    // MARK: Subtypes
    typealias View = UIViewController
    
    // MARK: Properties
    let module: Module
    
    func build() -> View {
        let view: View
        
        switch module {
        // Menu
        case let .menu(title, menuProvider):
            let router = ModuleRouter()
            let presenter = MenuViewPresenter(
                title: title,
                dataSource: menuProvider,
                router: router
            )
            
            view = MenuViewController(
                presenter: presenter
            )
            
            router.view = view
            
        // List
        case let .list(title, listProvider):
            let presenter = ListViewPresenter(
                title: title,
                dataSource: listProvider
            )
            view = ListViewController(
                presenter: presenter
            )
            
        // Log
        case let .log(title, logProvider):
            let router = LogViewRouter()
            let presenter = LogViewPresenter(
                title: title,
                provider: logProvider,
                router: router
            )
            let viewController = LogViewController(
                presenter: presenter
            )
            
            presenter.view = viewController
            router.view = viewController
            view = viewController
        }
        
        return view
    }
}
