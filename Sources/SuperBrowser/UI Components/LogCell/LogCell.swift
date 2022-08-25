//
//  LogCell.swift
//  
//
//  Created by Nikita Mikheev on 23.08.2022.
//

import UIKit

final class LogCell: UITableViewCell, ReusableNibCell {
    // MARK: Subviews
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
}

// MARK: - Configurable
extension LogCell: Configurable {
    typealias Model = LogRecord
    
    func configure(with model: LogRecord) {
        statusLabel.text = String(model.status ?? "⚪️")
        titleLabel.text = model.title
        titleLabel.lineBreakMode = .byTruncatingHead
        messageLabel.text = model.message ?? ""
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
    }
}
