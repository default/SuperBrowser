//
//  MenuItemProtocol.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import UIKit

public protocol MenuItemProtocol {
    var id: String { get }
    var icon: Character { get }
    var title: String { get }
}
