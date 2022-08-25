//
//  MenuProviding.swift
//  Created by Nikita Mikheev on 13.03.2022.
//

import Foundation

public enum Module {
    case menu(String, MenuProviding)
    case list(String, ListProviding)
    case log(String, LogProviding)
}

public protocol MenuProviding {
    var sections: [MenuSection] { get }
    func destination(for item: MenuItemProtocol) -> Module?
}
