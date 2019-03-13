//
//  ChatViewDataSource.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import DeepDiff
import AsyncDisplayKit

private struct DiffAwareItem: DiffAware {
  var diffId: Int
  init(chatItem: ChatBaseMessage) {
    diffId = Int(chatItem.messageId)
  }

  static func compareContent(_ a: DiffAwareItem, _ b: DiffAwareItem) -> Bool {
    return true
  }
}

class ChatViewDataSource: NSObject {

  private let collectionNode: ASCollectionNode
  private var messages: [ChatBaseMessage] = []

  init(collectionNode: ASCollectionNode) {
    self.collectionNode = collectionNode
  }

  func reload(with messages: [ChatBaseMessage]) {
    if collectionNode.delegate == nil && collectionNode.dataSource == nil {
      collectionNode.dataSource = self
      collectionNode.delegate = self
    }
    let changes = diff(old: self.messages.map { DiffAwareItem(chatItem: $0)}, new: messages.map { DiffAwareItem(chatItem: $0) })
    collectionNode.view.reload(changes: changes, updateData: { [weak self] in
      self?.messages = messages
    })
  }
}

extension ChatViewDataSource: ASCollectionDelegate, ASCollectionDataSource {
  func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }

  func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
    let message = messages[indexPath.row]
    return { () -> ASCellNode in
      switch message.type {
      case .text:
        return ChatTextMessageNode(with: message, isIncoming: indexPath.row % 2 == 0)
      case .photo:
        return ChatBaseMessageNode(isIncoming: false)
      }
    }
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print(scrollView.contentOffset)
  }
}
