//
//  ModuleRouter.swift
//  Created by Nikita Mikheev on 13.03.2022.
//

import Foundation
import UIKit

protocol ModuleRouting {
    var view: UIViewController? { get }
    func route(to module: Module)
}

class ModuleRouter: ModuleRouting {
    weak var view: UIViewController?
    
    // MARK: Interface
    func route(to module: Module) {
        let controller = ModuleAssembler(module: module).build()
        view?.navigationController?.pushViewController(controller, animated: true)
    }
}
