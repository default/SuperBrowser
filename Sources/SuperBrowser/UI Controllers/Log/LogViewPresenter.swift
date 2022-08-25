//
//  File.swift
//  
//
//  Created by Nikita Mikheev on 23.08.2022.
//

import Foundation

protocol LogViewInput: AnyObject {
    func reloadData()
}

protocol LogViewRouting {
    func openDetailView(for list: ListProviding)
}

final class LogViewPresenter {
    // MARK: References
    weak var view: LogViewInput?
    
    // MARK: Properties
    var controllerTitle: String?
    private var displayedSections: [LogSection] = []
    
    // MARK: Dependencies
    private let provider: LogProviding
    private let router: LogViewRouting
    
    // MARK: Initializers
    init(
        title: String,
        provider: LogProviding,
        router: LogViewRouting
    ) {
        self.controllerTitle = title
        self.provider = provider
        self.router = router
    }
    
    // MARK: Internal
    private func reloadData() {
        displayedSections = provider.makeSections()
        view?.reloadData()
    }
}

// MARK: - LogViewPresenting
extension LogViewPresenter: LogViewPresenting {
    // MARK: View Delegate
    func viewWillAppear() {
        reloadData()
    }
    
    // MARK: Data sourcing
    func numberOfSections() -> Int {
        displayedSections.count
    }
    func numberOfRecords(in section: Int) -> Int {
        displayedSections[section].records.count
    }
    func record(forSection section: Int, row: Int) -> LogRecord {
        displayedSections[section].records[row]
    }
    
    func sectionTitle(for section: Int) -> String {
        displayedSections[section].title
    }
    
    // MARK: User interactivity
    func didUserSelectRecord(at section: Int, row: Int) {
        let record = record(forSection: section, row: row)
        let logEntryList = LogEntryList(record: record)
        router.openDetailView(for: logEntryList)
    }
}
