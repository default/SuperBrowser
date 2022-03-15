//
//  MenuSection.swift
//  Created by Nikita Mikheev on 13.03.2022.
//

import Foundation

public struct MenuSection {
    let title: String
    let items: [MenuItemProtocol]
    
    // MARK: Initializers
    public init(
        title: String,
        items: [MenuItemProtocol]
    ) {
        self.title = title
        self.items = items
    }
}
