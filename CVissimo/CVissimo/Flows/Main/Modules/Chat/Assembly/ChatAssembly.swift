//
//  ChatAssembly.swift
//  CVissimo
//
//  Created Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

class ChatAssembly {
  
  static func createChatModule(router: ChatRouter) -> Presentable? {

    let view = ChatViewController()
    let interactor = ChatInteractor()
    let presenter = ChatPresenter(interactor: interactor, view: view, router: router)
    view.output = presenter
    interactor.output = presenter
    return view
  }
}
