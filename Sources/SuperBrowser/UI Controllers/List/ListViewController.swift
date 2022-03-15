//
//  ListViewController.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import UIKit

protocol ListViewPresenting: ViewDelegate {
    var numberOfSections: Int { get }
    func titleForSection(atIndex index: Int) -> String?
    func numberOfItems(inSection index: Int) -> Int
    func listItemModel(atIndex index: Int, section: Int) -> ListCell.Model?
    
    func didUserSelect(item index: Int, section: Int)
}

final class ListViewController<Presenter: ListViewPresenting>:
    PresentedController<Presenter>,
    UITableViewDataSource,
    UITableViewDelegate
{
    // MARK: Subviews
    private let tableView = UITableView(
        frame: .zero,
        style: .grouped
    )
    
    // MARK: Initializers
    override init(
        presenter: Presenter
    ) {
        super.init(presenter: presenter)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        title = presenter.controllerTitle
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = tableView
        setupView()
    }
    
    // MARK: Setup
    private func setupView() {
        // Table View
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
    }
    
    // MARK: Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didUserSelect(item: indexPath.row, section: indexPath.section)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        36
    }
    
    // MARK: DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems(inSection: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = presenter.listItemModel(
            atIndex: indexPath.row,
            section: indexPath.section
        ) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeue(ListCell.self)
        cell.configure(with: model)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.titleForSection(atIndex: section)
    }
}
