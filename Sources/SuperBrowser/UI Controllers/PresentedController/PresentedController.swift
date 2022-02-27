//
//  PresentedController.swift
//  Created by Nikita Mikheev on 27.02.2022.
//

import UIKit

protocol ViewDelegate: AnyObject {
    var controllerTitle: String? { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

extension ViewDelegate {
    var controllerTitle: String? { nil }
    
    func viewDidLoad() { }
    func viewWillAppear() { }
    func viewDidAppear() { }
    func viewWillDisappear() { }
    func viewDidDisappear() { }
}

class PresentedController<Presenter: ViewDelegate>: UIViewController {
    // MARK: Properties
    let presenter: Presenter
    
    // MARK: Initializers
    init(
        presenter: Presenter
    ) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        title = presenter.controllerTitle
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
}
