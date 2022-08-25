//
//  LogViewRouter.swift
//  
//
//  Created by Nikita Mikheev on 24.08.2022.
//

import UIKit

final class LogViewRouter {
    // MARK: Dependencies
    weak var view: UIViewController?
}

// MARK: - LogViewRouting
extension LogViewRouter: LogViewRouting {
    func openDetailView(for list: ListProviding) {
        let controller = ModuleAssembler(module: .list("Log Entry", list)).build()
        view?.navigationController?.pushViewController(controller, animated: true)
    }
}
