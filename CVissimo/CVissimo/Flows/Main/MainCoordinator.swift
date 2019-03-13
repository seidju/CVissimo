//
//  MainCoordinator.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 19/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

final class MainCoordinator: BaseCoordinator {

  private let router: Router

  init(router: Router) {
    self.router = router
  }

  override func start() {
    showPortfolioModule()
  }

  private func showChatModule() {
    let module = ChatAssembly.createChatModule(router: self)
    router.push(module, hideBar: false)
  }

  private func showPortfolioModule() {
    let module = PortfolioAssembly.createPortfolioModule(router: self)
    router.setRootModule(module, animated: false)
  }

}

extension MainCoordinator: PortfolioRouter {
  func showChat() {
    showChatModule()
  }
}

extension MainCoordinator: ChatRouter {

}
