//
//  LogSection.swift
//  
//
//  Created by Nikita Mikheev on 23.08.2022.
//

import Foundation

public struct LogSection {
    let title: String
    let records: [LogRecord]
    
    public init(
        title: String,
        records: [LogRecord]
    ) {
        self.title = title
        self.records = records
    }
}
