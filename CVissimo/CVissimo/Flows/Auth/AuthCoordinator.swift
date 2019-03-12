//
//  AuthCoordinator.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 17/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

final class AuthCoordinator: BaseCoordinator {

  private let router: Router
  private weak var output: AuthCoordinatorOutput?

  init(router: Router, output: AuthCoordinatorOutput) {
    self.router = router
    self.output = output
  }

  override func start() {
    showSignInModule()
  }

  private func showSignInModule() {
    let module = SignInAssembly.createSignInModule(router: self)
    router.setRootModule(module, animated: false)
  }
}

extension AuthCoordinator: SignInRouter {

}
