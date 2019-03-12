//
//  SignInPresenter.swift
//  CVissimo
//
//  Created Pavel Shatalov on 19/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

final class SignInPresenter {

  private weak var view: SignInViewInput?
  private weak var router: SignInRouter?
  private let interactor: SignInInteractorInput

  init(interactor: SignInInteractorInput, view: SignInViewInput, router: SignInRouter) {
    self.router = router
    self.interactor = interactor
    self.view = view
  }

}

extension SignInPresenter: SignInInteractorOutput {

}

extension SignInPresenter: SignInViewOutput {

}
