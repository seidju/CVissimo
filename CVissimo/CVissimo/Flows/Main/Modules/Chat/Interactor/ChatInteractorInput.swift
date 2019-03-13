//
//  ChatInteractorInput.swift
//  CVissimo
//
//  Created Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

enum MessageFetchingDirection {
  case forward
  case backward
}

protocol ChatInteractorInput {

  func getInitialMessages(count: Int)
  func getMessages(from messageId: UInt64, count: Int, direction: MessageFetchingDirection)

}
