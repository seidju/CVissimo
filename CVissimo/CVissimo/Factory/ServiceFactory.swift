//
//  ServiceFactory.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 18/04/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation


struct ServiceFactory {

  private let coreFactory: CoreFactory
  init(coreFactory: CoreFactory) {
    self.coreFactory = coreFactory
  }
  
  func makeRestService() -> RestService {
    return RestServiceImp()
  }
}
