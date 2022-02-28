//
//  ValueFormatter.swift
//  Created by Nikita Mikheev on 28.02.2022.
//

import Foundation

final class ValueFormatter {
    // MARK: Dependencies
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    // MARK: Interface
    static func formatted(_ date: Date) -> String {
        dateFormatter.string(from: date)
    }
}
