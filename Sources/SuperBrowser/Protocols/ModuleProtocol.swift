//
//  ModuleProtocol.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import UIKit

protocol ModuleProtocol {
    associatedtype View: UIViewController
    func build() -> View
}
