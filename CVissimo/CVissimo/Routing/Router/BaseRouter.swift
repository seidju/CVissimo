//
//  BaseRouter.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 17/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import UIKit

final class BaseRouter: NSObject, Router {
  
  private weak var tabBarRootController: UITabBarController?
  private weak var rootController: UINavigationController?
  private var completions: [UIViewController : () -> Void]
  
  init(rootController: UITabBarController) {
    self.tabBarRootController = rootController
    completions = [:]
  }
  
  init(rootController: UINavigationController) {
    self.rootController = rootController
    completions = [:]
  }
  
  var topModule: Presentable? {
    return rootController?.topViewController
  }
  
  private func setNavBarAppearance() {
    rootController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22.0)]
  }
  
  func toPresent() -> UIViewController? {
    return rootController
  }
  
  func present(_ module: Presentable?) {
    present(module, animated: true)
  }
  
  func present(_ module: Presentable?, animated: Bool) {
    guard let controller = module?.toPresent() else { return }
    rootController?.present(controller, animated: animated, completion: nil)
  }
  
  func dismissModule() {
    dismissModule(animated: true, completion: nil)
  }
  
  func dismissModule(animated: Bool, completion: (() -> Void)?) {
    rootController?.dismiss(animated: animated, completion: completion)
  }
  
  func push(_ module: Presentable?, hideBar: Bool) {
    push(module, animated: true, hideBar: hideBar)
  }
  
  func push(_ module: Presentable?, animated: Bool, hideBar: Bool) {
    push(module, animated: animated, hideBar: hideBar, completion: nil)
  }
  
  func push(_ module: Presentable?, animated: Bool, hideBar: Bool, completion: (() -> Void)?) {
    guard
      let controller = module?.toPresent(),
      (controller is UINavigationController == false)
      else { assertionFailure("Deprecated push UINavigationController."); return }
    
    if let completion = completion {
      completions[controller] = completion
    }
    rootController?.setNavigationBarHidden(hideBar, animated: false)
    rootController?.pushViewController(controller, animated: animated)
  }
  
  func popModule() {
    popModule(animated: true)
  }
  
  func popModule(animated: Bool) {
    if let controller = rootController?.popViewController(animated: animated) {
      runCompletion(for: controller)
    }
  }
  
  func setRootModule(_ module: Presentable?, animated: Bool) {
    setRootModule(module, hideBar: false, animated: animated)
  }
  
  func setRootModule(_ module: Presentable?, hideBar: Bool, animated: Bool = true) {
    guard let controller = module?.toPresent() else { return }
    if let top = topModule?.toPresent(), controller.isKind(of: top.classForCoder) {
      return
    }
    
    rootController?.setViewControllers([controller], animated: animated)
    rootController?.isNavigationBarHidden = hideBar
  }
  
  func popToRootModule(animated: Bool) {
    if let controllers = rootController?.popToRootViewController(animated: animated) {
      controllers.forEach { controller in
        runCompletion(for: controller)
      }
    }
  }
  
  private func runCompletion(for controller: UIViewController) {
    guard let completion = completions[controller] else { return }
    completion()
    completions.removeValue(forKey: controller)
  }
}
