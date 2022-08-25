//
//  LogViewController.swift
//  
//
//  Created by Nikita Mikheev on 23.08.2022.
//

import UIKit

protocol LogViewPresenting: ViewDelegate {
    func numberOfSections() -> Int
    func numberOfRecords(in section: Int) -> Int
    func sectionTitle(for section: Int) -> String
    
    func record(forSection section: Int, row: Int) -> LogRecord
    
    func didUserSelectRecord(at section: Int, row: Int)
}

final class LogViewController<Presenter: LogViewPresenting>:
    PresentedController<Presenter>,
    UITableViewDataSource,
    UITableViewDelegate
{
    // MARK: Subviews
    private let shortcutsView = ShortcutsView()
    private let tableView = UITableView(
        frame: .zero,
        style: .grouped
    )
    
    // MARK: Dependencies
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.locale = Locale(identifier: "de-DE")
        return formatter
    }()
    
    // MARK: Initializers
    override init(
        presenter: Presenter
    ) {
        super.init(presenter: presenter)
        
        shortcutsView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        title = presenter.controllerTitle
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: Setup
    private func setupView() {
        // Shortcuts View
        view.addSubview(shortcutsView)
        shortcutsView.translatesAutoresizingMaskIntoConstraints = false
        shortcutsView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        shortcutsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        shortcutsView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        shortcutsView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Table View
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: shortcutsView.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Self
        view.backgroundColor = .white
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didUserSelectRecord(at: indexPath.section, row: indexPath.row)
    }
    
    // MARK: TableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRecords(in: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.record(forSection: indexPath.section, row: indexPath.row)
        
        let cell = tableView.dequeue(LogCell.self)
        cell.configure(with: model)
        
        if model.embeddedLists?.isEmpty ?? true {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.sectionTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        51
    }
    
    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let model = presenter.record(forSection: indexPath.section, row: indexPath.row)
        
        return UISwipeActionsConfiguration(
            actions: [
                UIContextualAction(
                    style: .normal,
                    title: dateFormatter.string(from: model.date),
                    handler: { _, _, handle in handle(false) }
                )
            ]
        )
    }
}

// MARK: - ShortcutsViewDelegate
extension LogViewController: ShortcutsViewDelegate {
    func didUserPickShortcut(at index: Int) {
        guard tableView.numberOfSections > index else {
            return
        }
        
        tableView.scrollToRow(
            at: IndexPath(row: NSNotFound, section: index),
            at: .top,
            animated: true
        )
    }
}

// MARK: - LogViewInput
extension LogViewController: LogViewInput {
    func reloadData() {
        let sectionTitles = (0..<presenter.numberOfSections()).map { index in
            presenter.sectionTitle(for: index)
        }
        
        shortcutsView.configure(
            with: ShortcutsView.Model(
                titles: sectionTitles
            )
        )
        
        tableView.reloadData()
    }
}
