//
//  ReusableNibCell.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import UIKit

protocol ReusableNibCell where Self: UITableViewCell {
    static var nib: UINib { get }
    static var reuseIdentifier: String { get }
}
extension ReusableNibCell {
    static var className: String {
        String(describing: self)
    }
    static var nib: UINib {
        UINib(
            nibName: className,
            bundle: .module
        )
    }
    static var reuseIdentifier: String {
        className
    }
}

// MARK: - UITableView + ReusableCellRepresentable
extension UITableView {
    func register(_ cell: ReusableNibCell.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    func register(_ cells: [ReusableNibCell.Type]) {
        for cell in cells {
            register(cell)
        }
    }
    func dequeue<Cell: ReusableNibCell>(_ cellType: Cell.Type) -> Cell {
        register(cellType)
        return dequeueReusableCell(withIdentifier: cellType.reuseIdentifier) as! Cell
    }
}
