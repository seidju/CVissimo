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

}
