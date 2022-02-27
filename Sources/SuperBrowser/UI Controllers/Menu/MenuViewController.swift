//
//  MenuViewController.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import UIKit

protocol MenuViewPresenter: ViewDelegate {
    var items: [MenuItemProtocol] { get }
    
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
    private var items: [MenuItemProtocol] {
        presenter.items
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
        
        let item = items[indexPath.row]
        presenter.didUserSelect(item: item)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell = tableView.dequeue(MenuCell.self)
        cell.accessoryType = .disclosureIndicator
        cell.configure(with: item)
        
        return cell
    }
}
