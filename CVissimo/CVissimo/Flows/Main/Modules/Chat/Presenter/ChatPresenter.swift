//
//  ChatPresenter.swift
//  CVissimo
//
//  Created Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

class ChatPresenter {

  private enum LoadHistoryStatus {
    case none
    case backward
    case forward
  }

  private weak var view: ChatViewInput?
  private weak var router: ChatRouter?
  private let interactor: ChatInteractorInput
  private var messages = [ChatBaseMessage]()

  private var hasMoreMessagesBackward = true
  private var hasMoreMessagesForward = true
  
  private var loadMessagesStatus = LoadHistoryStatus.none

  init(interactor: ChatInteractorInput, view: ChatViewInput, router: ChatRouter) {
    self.interactor = interactor
    self.view = view
    self.router = router
  }
  
  private func loadPrevious() {
    if let firstMessage = messages.last {
      interactor.getMessages(from: firstMessage.messageId, count: Constants.pageSize, direction: .backward)
    }
  }
  
  private func loadNext() {
    if let lastMessage = messages.first {
      interactor.getMessages(from: lastMessage.messageId, count: Constants.pageSize, direction: .forward)
    }
  }
}

extension ChatPresenter: ChatInteractorOutput {
  func didObtainInitialMessages(_ messages: [ChatBaseMessage]) {
    self.messages = messages.reversed()
    loadMessagesStatus = .none
    view?.update(messages: messages)
  }

  func didObtainMessages(_ messages: [ChatBaseMessage], isBackward: Bool, hasMore: Bool) {
    loadMessagesStatus = .none
    let filteredMessages = messages.reversed().filter { message in
      return !self.messages.contains(where: {$0.messageId == message.messageId})
    }
    if isBackward {
      hasMoreMessagesBackward = hasMore
      self.messages.append(contentsOf: filteredMessages)
    } else {
      hasMoreMessagesForward = hasMore
      self.messages.insert(contentsOf: filteredMessages, at: 0)
    }
    view?.update(messages: self.messages)
  }
}

extension ChatPresenter: ChatViewOutput {

  func viewDidLoad() {
    interactor.getInitialMessages(count: 100)
  }

  func didPressSendTextButton(_ text: String) {
    let messageId = UInt64.random(in: 0...4294967295)
    let message = ChatTextMessage(messageId: messageId, text: text, senderId: "me")
    messages.insert(message, at: 0)
    view?.update(messages: messages)
  }

  func didScrollCloseToBottom() {
    loadNext()
  }

  func didScrollCloseToTop() {
    loadPrevious()
  }
}

extension ChatPresenter {
  private enum Constants {
    static let pageSize: Int = 50
    static let maximumWindowSize: Int = 500
  }
}


let texts: [String] = ["Hi! I'm new chat layout",
                       "When using Automatic Subnode Management with the ASOverlayLayoutSpec, the nodes may sometimes appear in the wrong order. This is a known",
                       "The background spec’s size is calculated from the child’s size. In the diagram below, the child is the blue layer. The child’s size is",
                       "The background spec’s size is calculated from the child’s size. In the diagram below, the child is the blue layer. The child’s size is, hen using Automatic Subnode Management with the ASOverlayLayoutSpec, the nodes may sometimes appear in the wrong order. This is a known hen using Automatic Subnode Management with the ASOverlayLayoutSpec, the nodes may sometimes appear in the wrong order. This is a knownhen using Automatic Subnode Management with the ASOverlayLayoutSpec, the nodes may sometimes appear in the wrong order. This is a known"]
