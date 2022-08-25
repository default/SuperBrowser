//
//  ReusableNibCell.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import UIKit

extension NSObject {
    static var className: String {
        String(describing: self)
    }
}

protocol ReusableNibCell where Self: UITableViewCell {
    static var nib: UINib { get }
}
extension ReusableNibCell {
    static var nib: UINib {
        UINib(
            nibName: className,
            bundle: .module
        )
    }
}

// MARK: - UITableView + ReusableCellRepresentable
extension UITableView {
    fileprivate func register(_ cell: UITableViewCell.Type) {
        guard !(cell is ReusableNibCell.Type) else {
            registerNibCell(cell as! ReusableNibCell.Type)
            return
        }
        
        register(cell, forCellReuseIdentifier: cell.className)
    }
    fileprivate func registerNibCell(_ cell: ReusableNibCell.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.className)
    }
    
    func dequeue<Cell: UITableViewCell>(_ cellType: Cell.Type) -> Cell {
        register(cellType)
        return dequeueReusableCell(withIdentifier: cellType.className) as! Cell
    }
}
