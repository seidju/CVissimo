//
//  ChatPresenter.swift
//  CVissimo
//
//  Created Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

class ChatPresenter {

  private weak var view: ChatViewInput?
  private weak var router: ChatRouter?
  private let interactor: ChatInteractorInput
  private var messages = [ChatBaseMessage]()

  init(interactor: ChatInteractorInput, view: ChatViewInput, router: ChatRouter) {
    self.interactor = interactor
    self.view = view
    self.router = router
  }
}

extension ChatPresenter: ChatInteractorOutput {

}

extension ChatPresenter: ChatViewOutput {

  func viewDidLoad() {
    var messages = [ChatBaseMessage]()
    for i in 0...1000 {
      let message = ChatTextMessage(messageId: UInt64(i), text: texts.randomElement() ?? "", senderId: "me")
      messages.append(message)
    }
    self.messages = messages
    view?.update(messages: messages)
  }

  func didPressSendTextButton(_ text: String) {
    let messageId = UInt64.random(in: 0...4294967295)
    let message = ChatTextMessage(messageId: messageId, text: text, senderId: "me")
    messages.insert(message, at: 0)
    view?.update(messages: messages)
  }
}

let texts: [String] = ["Hi! I'm new chat layout",
                       "When using Automatic Subnode Management with the ASOverlayLayoutSpec, the nodes may sometimes appear in the wrong order. This is a known",
                       "The background spec’s size is calculated from the child’s size. In the diagram below, the child is the blue layer. The child’s size is",
                       "The background spec’s size is calculated from the child’s size. In the diagram below, the child is the blue layer. The child’s size is, hen using Automatic Subnode Management with the ASOverlayLayoutSpec, the nodes may sometimes appear in the wrong order. This is a known hen using Automatic Subnode Management with the ASOverlayLayoutSpec, the nodes may sometimes appear in the wrong order. This is a knownhen using Automatic Subnode Management with the ASOverlayLayoutSpec, the nodes may sometimes appear in the wrong order. This is a known"]
