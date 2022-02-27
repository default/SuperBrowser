//
//  MenuCell.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import UIKit
import WindowInstanceManager

public protocol SuperBrowserProtocol: AnyObject {
    var dataSource: SuperBrowserDataSource? { get set }
    
    func launch()
    func close()
}

public protocol SuperBrowserDataSource: AnyObject {
    var application: UIApplication { get }
    
    var systemListProvider: ListProviding { get }
}

public final class SuperBrowser {
    // MARK: Static
    public static let shared: SuperBrowserProtocol = {
        SuperBrowser()
    }()
    
    // MARK: Properties
    private var window: ManagedWindowReference?
    
    // MARK: Dependencies
    public weak var dataSource: SuperBrowserDataSource?
    private var windowManager: WindowInstanceManaging?
    
    // MARK: Initializers
    private init() { }
    
    // MARK: Internal
    private func initializeIfNeeded() {
        guard let dataSource = dataSource else {
            assertionFailure("DataSource not set for SuperBrowser")
            return
        }
        
        guard windowManager == nil else {
            return
        }
        
        windowManager = WindowInstanceManager.shared(
            for: dataSource.application
        )
    }
}

// MARK: - SuperBrowserProtocol
extension SuperBrowser: SuperBrowserProtocol {
    public func launch() {
        initializeIfNeeded()
        
        guard let dataSource = dataSource else {
            assertionFailure("dataSource value not assigned")
            return
        }
        
        guard window == nil else {
            // Already launched
            return
        }
        
        let controller = RootModule().build()
        let navi = NavigationController(
            rootViewController: controller
        )
        
        let window = windowManager!.instance(
            withRoot: navi,
            styleOverride: .light
        )
        windowManager!.makeKey(window)
        
        self.window = window
    }
    public func close() {
        guard let window = window else {
            return
        }
        
        windowManager?.resign(window)
        self.window = nil
    }
}


