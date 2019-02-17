//
//  Router.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 17/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

protocol Router: Presentable {

  func present(_ module: Presentable?)
  func present(_ module: Presentable?, animated: Bool)

  func push(_ module: Presentable?, hideBar: Bool)
  func push(_ module: Presentable?, animated: Bool, hideBar: Bool)
  func push(_ module: Presentable?, animated: Bool, hideBar: Bool, completion: (() -> Void)?)

  func popModule()
  func popModule(animated: Bool)

  func dismissModule()
  func dismissModule(animated: Bool, completion: (() -> Void)?)

  func setRootModule(_ module: Presentable?, animated: Bool)
  func setRootModule(_ module: Presentable?, hideBar: Bool, animated: Bool)

  func popToRootModule(animated: Bool)

  var topModule: Presentable? { get }
}
