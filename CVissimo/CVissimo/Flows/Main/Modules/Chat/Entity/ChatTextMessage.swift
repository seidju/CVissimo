//
//  ChatTextMessage.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import DeepDiff

struct ChatTextMessage: ChatBaseMessage {
  let messageId: UInt64
  let senderId: String
  var type: MessageType

  init(messageId: UInt64, text: String, senderId: String) {
    self.messageId = messageId
    self.type = MessageType.text(text)
    self.senderId = senderId
  }
}

extension ChatTextMessage: DiffAware {
  var diffId: Int {
    return Int(messageId)
  }

  static func compareContent(_ a: ChatTextMessage, _ b: ChatTextMessage) -> Bool {
    return true
  }
}
