//
//  LogRecord.swift
//  
//
//  Created by Nikita Mikheev on 23.08.2022.
//

import Foundation
import UIKit

public struct LogRecord {
    let date: Date
    let title: String
    let status: String?
    let message: String?
    let embeddedLists: [ListProviding]?
    
    // MARK: Initializers
    public init(
        date: Date,
        title: String,
        status: String?,
        message: String?,
        embeddedLists: [ListProviding]?
    ) {
        self.date = date
        self.title = title
        self.status = status
        self.message = message
        self.embeddedLists = embeddedLists
    }
}
