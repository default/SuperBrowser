//
//  ListSection.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import Foundation

public struct ListSection {
    let title: String
    let items: [ListItem]
    
    // MARK: Initializers
    public init(
        title: String,
        items: [ListItem]
    ) {
        self.title = title
        self.items = items
    }
}
