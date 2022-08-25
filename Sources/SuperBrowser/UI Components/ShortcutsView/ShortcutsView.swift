//
//  ShortcutsView.swift
//  
//
//  Created by Nikita Mikheev on 24.08.2022.
//

import UIKit

protocol ShortcutsViewDelegate: AnyObject {
    func didUserPickShortcut(at index: Int)
}

final class ShortcutsView: UIView {
    // MARK: Delegate
    weak var delegate: ShortcutsViewDelegate?
    
    // MARK: Subviews
    private let scrollView = UIScrollView()
    private let itemStackView = UIStackView()
    
    // MARK: Initializers
    init() {
        super.init(frame: .zero)
        setupView()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupView() {
        // Scroll View
        scrollView.contentInset.left = 20
        scrollView.contentInset.right = 20
        scrollView.showsHorizontalScrollIndicator = false
        
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // Stack View
        itemStackView.axis = .horizontal
        itemStackView.spacing = 8
        itemStackView.alignment = .center
        
        scrollView.addSubview(itemStackView)
        itemStackView.translatesAutoresizingMaskIntoConstraints = false
        itemStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        itemStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        itemStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        itemStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    // MARK: User interactivity
    @objc private func itemTapAction(_ sender: UIButton) {
        let index = sender.tag
        delegate?.didUserPickShortcut(at: index)
    }
}

// MARK: - Configurable
extension ShortcutsView: Configurable {
    struct Model {
        let titles: [String]
    }
    
    func configure(with model: Model) {
        itemStackView.arrangedSubviews.forEach { view in
            itemStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for index in 0..<model.titles.count {
            let title = model.titles[index]
            
            let button = UIButton()
            button.setTitle(title, for: [])
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            button.setTitleColor(.label, for: .normal)
            
            button.contentEdgeInsets = UIEdgeInsets(
                top: 6,
                left: 12,
                bottom: 6,
                right: 12
            )
            
            button.layer.cornerRadius = 16
            button.layer.masksToBounds = true
            
            button.layer.borderColor = UIColor.label.cgColor
            button.layer.borderWidth = 2
            
            button.tag = index
            
            button.addTarget(
                self,
                action: #selector(itemTapAction(_:)),
                for: .touchUpInside
            )
            
            itemStackView.addArrangedSubview(button)
        }
    }
}

