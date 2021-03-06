//
//  ApplicationCoordinator.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 17/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {

  private let router: Router

  init(router: Router) {
    self.router = router
  }

  override func start() {
    runMainFlow()
  }

  private func runAuthFlow() {
    let coordinator = AuthCoordinator(router: router, output: self)
    addDependency(coordinator)
    coordinator.start()
  }

  private func runMainFlow() {
    let coordinator = MainCoordinator(router: router)
    addDependency(coordinator)
    coordinator.start()
  }
}

extension ApplicationCoordinator: AuthCoordinatorOutput {

  func flowFinished(_ coordinator: Coordinator) {
    removeDependency(coordinator)
  }

}
