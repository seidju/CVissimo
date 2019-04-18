//
//  ChatMessage.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

protocol ChatBaseMessage {

  var messageId: UInt64 { get }
  var senderId: String { get }
  var type: MessageType { get }

}
