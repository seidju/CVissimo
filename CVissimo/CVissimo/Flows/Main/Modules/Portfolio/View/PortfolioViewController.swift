//
//  PortfolioViewController.swift
//  CVissimo
//
//  Created Pavel Shatalov on 13/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController {

  var output: PortfolioViewOutput?

  private lazy var chatButton: UIButton = {
    let button = UIButton(frame: .zero)
    button.setTitle("Show chat", for: .normal)
    button.addTarget(self, action: #selector(chatButtonTapped), for: .touchUpInside)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    layoutViews()
  }
  
  private func layoutViews() {
    view.addSubview(chatButton)
    chatButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      chatButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      chatButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  @objc private func chatButtonTapped() {
    output?.chatButtonTapped()
  }
}

extension PortfolioViewController: PortfolioViewInput {

}
