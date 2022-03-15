//
//  MenuViewController.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import UIKit

protocol MenuViewPresenting: ViewDelegate {
    var sections: [MenuSection] { get }
    func didUserSelect(item: MenuItemProtocol)
}

final class MenuViewController<Presenter: MenuViewPresenter>:
    PresentedController<Presenter>,
    UITableViewDataSource,
    UITableViewDelegate
{
    // MARK: Subviews
    private let tableView = UITableView(
        frame: .zero,
        style: .insetGrouped
    )
    
    // MARK: Properties
    private var sections: [MenuSection] {
        presenter.sections
    }
    
    // MARK: Initializers
    override init(
        presenter: Presenter
    ) {
        super.init(presenter: presenter)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = tableView
    }
    
    // MARK: Setup
    private func setupView() {
        // Table View
        tableView.backgroundColor = .secondarySystemBackground
    }

    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let item = self.item(at: indexPath) else {
            assertionFailure("No item at indexPath \(indexPath)")
            return
        }
        
        presenter.didUserSelect(item: item)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = self.item(at: indexPath) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeue(MenuCell.self)
        cell.accessoryType = .disclosureIndicator
        cell.configure(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard sections.count > section else {
            return nil
        }
        
        let title = sections[section].title
        guard !title.isEmpty else {
            return nil
        }
        
        return title
    }
    
    // MARK: Support
    private func item(at indexPath: IndexPath) -> MenuItemProtocol? {
        guard sections.count > indexPath.section else {
            return nil
        }
        
        guard sections[indexPath.section].items.count > indexPath.row else {
            return nil
        }
        
        return sections[indexPath.section].items[indexPath.row]
    }
}
