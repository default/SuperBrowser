//
//  ListCell.swift
//  
//
//  Created by Nikita Mikheev on 27.02.2022.
//

import UIKit

final class ListCell: UITableViewCell, ReusableNibCell {
    // MARK: Subviews
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var insetWidth: NSLayoutConstraint!
}

// MARK: - Configurable
extension ListCell: Configurable {
    struct Model {
        let level: Int
        let item: ListItem
    }
    
    func configure(with model: Model) {
        titleLabel.text = model.item.title
        valueLabel.text = model.item.value.valueDescription
        
        insetWidth.constant = CGFloat(model.level * 20)
        setNeedsLayout()
    }
}
