//
//  RootModule.swift
//  
//
//  Created by Nikita Mikheev on 27.02.2022.
//

import UIKit

enum RootMenuItem: String, MenuItemProtocol, CaseIterable {
    
    case system
    case persistentData
//    case network
//    case logs
//    case files
    
    // MARK: Protocol Conformance
    var id: String {
        rawValue
    }
    var icon: Character {
        switch self {
        case .system:
            return "⚙️"
        case .persistentData:
            return "📇"
//        case .network:
//            return "🌐"
//        case .logs:
//            return "🧾"
//        case .files:
//            return "📦"
        }
    }
    var title: String {
        switch self {
        case .persistentData:
            return "Persistent Data"
        default:
            return rawValue.capitalized
        }
    }
}

struct RootModule: ModuleProtocol {
    typealias View = UIViewController
    
    // MARK: Factories
    func build() -> UIViewController {
        let router = RootRouter()
        let presenter = RootPresenter(
            router: router
        )
        
        let controller = MenuViewController<RootPresenter>(
            presenter: presenter
        )
        
        controller.title = "SuperBrowser"
        router.viewController = controller
        
        return controller
    }
}


