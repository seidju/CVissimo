//
//  SignInAssembly.swift
//  CVissimo
//
//  Created Pavel Shatalov on 19/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

final class SignInAssembly {

  static func createSignInModule(router: SignInRouter) -> Presentable? {
    let view = SignInViewController()
    let interactor = SignInInteractor()
    let presenter = SignInPresenter(interactor: interactor, view: view, router: router)
    view.output = presenter
    interactor.output = presenter
    return view
  }
}
