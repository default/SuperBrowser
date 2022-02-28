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
extension NSString: ListValueRepresentable {
    public var valueDescription: String {
        (self as String).valueDescription
    }
}

// Collections
extension Array: ListValueRepresentable {
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
                    value: self[index] as? ListValueRepresentable ?? "⌧"
                )
            )
        }
        
        return items
    }
}
extension NSArray: ListValueRepresentable {
    public var valueDescription: String {
        (self as Array).valueDescription
    }
    public var sublist: [ListItem]? {
        (self as Array).sublist
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
extension NSDictionary: ListValueRepresentable {
    public var valueDescription: String {
        (self as Dictionary).valueDescription
    }
    public var sublist: [ListItem]? {
        (self as Dictionary).sublist
    }
}

// Date
extension Date: ListValueRepresentable {
    public var valueDescription: String {
        ValueFormatter.formatted(self)
    }
}
extension NSDate: ListValueRepresentable {
    public var valueDescription: String {
        ValueFormatter.formatted(self as Date)
    }
}

// Data
extension Data: ListValueRepresentable {
    public var valueDescription: String {
        "<Data>"
    }
}
extension NSData: ListValueRepresentable {
    public var valueDescription: String {
        (self as Data).valueDescription
    }
}

// UUID
extension UUID: ListValueRepresentable {
    public var valueDescription: String {
        uuidString
    }
}
