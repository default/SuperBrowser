//
//  ListableItem.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import Foundation
import UIKit

public struct ListItem {
    public let title: String
    public let value: ListValueRepresentable
    
    public init(
        title: String,
        value: ListValueRepresentable
    ) {
        self.title = title
        self.value = value
    }
}

public protocol ListValueRepresentable {
    var valueDescription: String { get }
    var sublist: [ListItem]? { get }
}
public extension ListValueRepresentable where Self: CustomStringConvertible {
    var valueDescription: String {
        description
    }
}
public extension ListValueRepresentable {
    var sublist: [ListItem]? { nil }
}

// Optional
extension Optional: ListValueRepresentable where Wrapped: ListValueRepresentable {
    public var valueDescription: String {
        switch self {
        case .none:
            return "nil"
        case .some(let wrapped):
            return wrapped.valueDescription
        }
    }
    public var sublist: [ListItem]? {
        switch self {
        case .none:
            return nil
        case .some(let wrapped):
            return wrapped.sublist
        }
    }
}

// Boolean
extension Bool: ListValueRepresentable { }

// Numeric
extension Int: ListValueRepresentable { }
extension Double: ListValueRepresentable { }
extension Float: ListValueRepresentable { }
extension CGFloat: ListValueRepresentable { }
extension NSNumber: ListValueRepresentable { }

// String
extension String: ListValueRepresentable {
    public var valueDescription: String {
        "\"" + description + "\""
    }
}

// Collections
extension Array: ListValueRepresentable where Element: ListValueRepresentable {
    public var valueDescription: String {
        isEmpty ? "[∅]" : "[...]"
    }
    public var sublist: [ListItem]? {
        guard !isEmpty else {
            return nil
        }
        
        var items = [ListItem]()
        items.reserveCapacity(count)
        
        for index in 0..<count {
            items.append(
                ListItem(
                    title: index.description,
                    value: self[index]
                )
            )
        }
        
        return items
    }
}
extension Set: ListValueRepresentable {
    public var valueDescription: String {
        isEmpty ? "[∅]" : "set [...]"
    }
    public var sublist: [ListItem]? {
        guard !isEmpty else {
            return nil
        }
        
        return map {
            ListItem(
                title: "",
                value: $0 as? ListValueRepresentable ?? "⌧"
            )
        }
    }
}


// Dictionary
extension Dictionary: ListValueRepresentable {
    public var valueDescription: String {
        isEmpty ? "[∅:∅]" : "[ : ]"
    }
    public var sublist: [ListItem]? {
        guard !isEmpty else {
            return nil
        }
        
        return keys.map { key in
            ListItem(
                title: (key as? CustomStringConvertible)?.description ?? "⌧",
                value: self[key] as? ListValueRepresentable ?? "⌧"
            )
        }
    }
}
extension Dictionary where Key: Comparable {
    public var sublist: [ListItem]? {
        guard !isEmpty else {
            return nil
        }
        
        return keys.sorted(by: <).map { key in
            ListItem(
                title: (key as? CustomStringConvertible)?.description ?? "⌧",
                value: self[key] as? ListValueRepresentable ?? "⌧"
            )
        }
    }
}

// Data
extension Data: ListValueRepresentable {
    public var valueDescription: String {
        "<Data>"
    }
}

// UUID
extension UUID: ListValueRepresentable {
    public var valueDescription: String {
        uuidString
    }
}
