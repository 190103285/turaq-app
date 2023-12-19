//
//  AlertController.swift
//  TuraqApp
//
//  Created by Akyl on 07.03.2023.
//

import UIKit

class AlertController: UIViewController {
    
    // MARK: - Private Properties
    
    private var actions: [AlertAction] = []
    
    private lazy var contentView: AlertView = {
        let view = AlertView()
        
        return view
    }()
    
    private lazy var transitioningController = AlertTransitioningController()
    
    // MARK: - Life Cycle
    
    public init(title: String? = nil, message: String? = nil, image: UIImage? = nil) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = transitioningController
        contentView.setTitle(title)
        contentView.setMessage(message)
        contentView.setImage(image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    // MARK: - Public Methods
    
    public func addAction(_ action: AlertAction) {
        action.addTarget(self, action: #selector(actionDidTap(_:)), for: .touchUpInside)
        actions.append(action)
    }
    
    // MARK: - Private Methods
    
    private func setupActions() {
        contentView.setActions(actions)
    }
    
    @objc
    private func actionDidTap(_ sender: AlertAction) {
        dismiss(animated: true) {
            sender.performAction()
        }
    }
}

