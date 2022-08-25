//
//  LogEntryList.swift
//  
//
//  Created by Nikita Mikheev on 24.08.2022.
//

import Foundation

struct LogEntryList {
    // MARK: Properties
    private let titlesSection: ListSection
    private var embeddedLists: [ListProviding]?
    
    // MARK: Initializers
    init(record: LogRecord) {
        titlesSection = ListSection(
            title: "Log Entry",
            items: [
                ListItem(title: "Status", value: record.status),
                ListItem(title: "Title", value: record.title),
                ListItem(title: "Message", value: record.message),
                ListItem(title: "Date", value: record.date)
            ]
        )
        
        embeddedLists = record.embeddedLists
    }
}

// MARK: - LogProviding
extension LogEntryList: ListProviding {
    func makeSections() -> [ListSection] {
        var sections = [titlesSection]
        embeddedLists?.forEach({ provider in
            sections.append(contentsOf: provider.makeSections())
        })
        
        return sections
    }
}
