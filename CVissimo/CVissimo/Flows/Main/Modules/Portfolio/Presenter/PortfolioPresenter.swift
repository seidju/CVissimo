//
//  PortfolioPresenter.swift
//  CVissimo
//
//  Created Pavel Shatalov on 13/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

class PortfolioPresenter {

  private weak var view: PortfolioViewInput?
  private let interactor: PortfolioInteractorInput
  private weak var router: PortfolioRouter?
  
  init(interactor: PortfolioInteractorInput, view: PortfolioViewInput, router: PortfolioRouter) {
    self.interactor = interactor
    self.view = view
    self.router = router
  }

}

extension PortfolioPresenter: PortfolioInteractorOutput {

}

extension PortfolioPresenter: PortfolioViewOutput {
  func chatButtonTapped() {
    router?.showChat()
  }
}
