//
//  Configurable.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import Foundation

protocol Configurable {
    associatedtype Model
    func configure(with model: Model)
}
