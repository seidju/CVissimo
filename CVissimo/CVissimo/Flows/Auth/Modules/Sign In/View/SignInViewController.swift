//
//  SignInViewController.swift
//  CVissimo
//
//  Created Pavel Shatalov on 19/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController {

  var output: SignInViewOutput?

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Sign In"
  }
}

extension SignInViewController: SignInViewInput {

}
