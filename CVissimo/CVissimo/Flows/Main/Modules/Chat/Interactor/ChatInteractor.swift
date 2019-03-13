//
//  ChatInteractor.swift
//  CVissimo
//
//  Created Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

class ChatInteractor {

  weak var output: ChatInteractorOutput?
  private var messages = [ChatBaseMessage]()

  init() {
    var messages = [ChatBaseMessage]()
    for i in 0...1000 {
      let message = ChatTextMessage(messageId: UInt64(i), text: "THIS IS MESSAGE #\(i)", senderId: "me")
      messages.append(message)
    }
    self.messages = messages
  }
}

extension ChatInteractor: ChatInteractorInput {
  func getInitialMessages(count: Int) {
    output?.didObtainInitialMessages(Array(messages.suffix(count)))
  }

  func getMessages(from messageId: UInt64, count: Int, direction: MessageFetchingDirection) {
    if let index = messages.firstIndex(where: { $0.messageId == messageId }) {
      let messageBatch: [ChatBaseMessage]
      switch direction {
      case .forward:
        let messageSlice = Array(messages[index...])
        messageBatch = Array(messageSlice.prefix(count))
      case .backward:
        let messageSlice = Array(messages[...index])
        messageBatch = Array(messageSlice.suffix(count))
      }
      output?.didObtainMessages(messageBatch, isBackward: direction == .backward, hasMore: true)
    }
  }

}
