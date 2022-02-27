//
//  SystemPresenter.swift
//  Created by Nikita Mikheev on 28.02.2022.
//

import Foundation
import UIKit

final class SystemPresenter {
    // MARK: Subtypes
    private typealias Model = ListCell.Model
    
    // MARK: Properties
    private var sectionTitles: [String]?
    private var sectionModels: [[Model]]?
    
    // MARK: Dependencies
    private let dataSource: ListProviding
    
    // MARK: Initializers
    init(
        dataSource: ListProviding
    ) {
        self.dataSource = dataSource
    }
    
    // MARK: Internal
    private func makeData() {
        let sections = dataSource.makeSetions()
        
        var sectionTitles = [String]()
        sectionTitles.reserveCapacity(sections.count)
        
        var sectionModels = [[Model]]()
        sectionModels.reserveCapacity(sections.count)
        
        for section in sections {
            sectionTitles.append(section.title)
            
            var models = [Model]()
            section.items.forEach { item in
                models.append(
                    contentsOf: makeItemModels(for: item, level: 0)
                )
            }
            sectionModels.append(models)
        }
        
        self.sectionTitles = sectionTitles
        self.sectionModels = sectionModels
    }
    
    // MARK: Support
    private func makeItemModels(for item: ListItem, level: Int) -> [Model] {
        guard let sublist = item.value.sublist else {
            return [
                Model(level: level, item: item)
            ]
        }
        
        var items = [Model]()
        items.append(
            Model(level: level, item: item)
        )
        
        sublist.forEach { subitem in
            items.append(
                contentsOf: makeItemModels(for: subitem, level: level + 1)
            )
        }
        
        return items
    }
    
}

// MARK: - ListViewPresenter
extension SystemPresenter: ListViewPresenter {
    var controllerTitle: String? {
        "System"
    }
    
    func viewDidLoad() {
        makeData()
    }
    
    var numberOfSections: Int {
        sectionModels?.count ?? 0
    }
    func titleForSection(atIndex index: Int) -> String? {
        sectionTitles?[index]
    }
    func numberOfItems(inSection index: Int) -> Int {
        sectionModels?[index].count ?? 0
    }
    func listItemModel(atIndex index: Int, section: Int) -> ListCell.Model? {
        sectionModels?[section][index]
    }
    
    func didUserSelect(item index: Int, section: Int) {
        guard let value = listItemModel(atIndex: index, section: section)?.item.value else {
            return
        }
        
        let text: String
        if let convertible = value as? CustomStringConvertible {
            text = convertible.description
        } else {
            text = value.valueDescription
        }
        
        UIPasteboard.general.string = text
        UIFeedback.vibrate()
    }
}
