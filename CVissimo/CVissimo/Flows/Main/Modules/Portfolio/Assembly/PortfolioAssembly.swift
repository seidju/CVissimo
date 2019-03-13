//
//  PortfolioAssembly.swift
//  CVissimo
//
//  Created Pavel Shatalov on 13/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

class PortfolioAssembly {

  static func createPortfolioModule(router: PortfolioRouter) -> Presentable? {
    let view = PortfolioViewController()
    let interactor = PortfolioInteractor()
    let presenter = PortfolioPresenter(interactor: interactor, view: view, router: router)
    view.output = presenter
    interactor.output = presenter
    return view
  }
}
