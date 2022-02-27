//
//  MenuCell.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import UIKit

final class MenuCell: UITableViewCell, ReusableNibCell {
    // MARK: Subviews
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
}

// MARK: - Configurable
extension MenuCell: Configurable {
    typealias Model = MenuItemProtocol
    
    func configure(with model: Model) {
        iconLabel.text = String(model.icon)
        titleLabel.text = model.title
    }
}
