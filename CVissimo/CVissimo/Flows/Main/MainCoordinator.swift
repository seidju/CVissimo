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
    showSignInModule()
  }

  private func showSignInModule() {
    let module = ChatAssembly.createChatModule(router: self)
    router.setRootModule(module, animated: false)
  }

}

extension MainCoordinator: ChatRouter {

}
