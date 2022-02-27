//
//  NavigationController.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import UIKit

final class NavigationController: UINavigationController {
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = UIColor(
            red: 0.15,
            green: 0.15,
            blue: 0.15,
            alpha: 1
        )
    }
    
    // MARK: User interactivity
    @objc private func closeAction() {
        SuperBrowser.shared.close()
    }
    
    // MARK: Support
    private func makeCloseButtonItem() -> UIBarButtonItem {
        let icon = UIImage(
            named: "cross",
            in: .module,
            with: nil
        )
        
        return UIBarButtonItem(
            image: icon,
            style: .plain,
            target: self,
            action: #selector(closeAction)
        )
    }
    
    // MARK: Override
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.rightBarButtonItem = makeCloseButtonItem()
        super.pushViewController(viewController, animated: animated)
    }
}
