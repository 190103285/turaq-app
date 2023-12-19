//
//  BaseNavigationController.swift
//  TuraqApp
//
//  Created by Akyl on 28.02.2023.
//

import UIKit

public protocol BaseNavigationControllerDelegate: AnyObject {
    func coordinatorNavigationControllerDidBack(_ navigationController: BaseNavigationController)
}

public class BaseNavigationController: UINavigationController {
    weak public var closingDelegate: BaseNavigationControllerDelegate?
    
    var duringPushAnimation = false
    
    private var transition: UIViewControllerAnimatedTransitioning?
    private var isClosingCancelled = false
    
    // MARK: - Init
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        delegate = self
        setup()
    }
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        delegate = self
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        duringPushAnimation = true
        isClosingCancelled = false
        setupInteractivePopGestureRecognizer()
        setupBackButton(for: viewController)
    }
    
    @discardableResult
    public override func popViewController(animated: Bool) -> UIViewController? {
        defer {
            if !isClosingCancelled {
                closingDelegate?.coordinatorNavigationControllerDidBack(self)
            }
        }
        return super.popViewController(animated: animated)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupStyle()
    }
    
    private func setupInteractivePopGestureRecognizer() {
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setupStyle() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = true
        navigationBar.tintColor = .black
    }
    
    private func setupBackButton(for viewController: UIViewController) {
        let backButton = BackBarButtonItem.make()
        backButton.tintColor = UIColor.mainBlue
        backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    // MARK: - Actions
    
    @objc
    private func backButtonTap(_ sender: UIBarButtonItem) {
        guard interactivePopGestureRecognizer?.isEnabled == true else {
            return
        }
        isClosingCancelled = false
        popViewController(animated: true)
    }
}

// MARK: - UINavigationControllerDelegate

extension BaseNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationController.Operation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {
        if let coordinator = navigationController.topViewController?.transitionCoordinator {
            coordinator.notifyWhenInteractionChanges { [weak self] (context) in
                guard let self = self else {
                    return
                }
                self.isClosingCancelled = context.isCancelled
                if !self.isClosingCancelled {
                    self.closingDelegate?.coordinatorNavigationControllerDidBack(self)
                }
            }
        }
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        guard let swipeNavigationController = navigationController as? BaseNavigationController else { return }
        swipeNavigationController.duringPushAnimation = false
    }
}

// MARK: - UIGestureRecognizerDelegate

extension BaseNavigationController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == self.interactivePopGestureRecognizer else {
            return true
        }
        isClosingCancelled = true
        return viewControllers.count > 1 && duringPushAnimation == false
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

