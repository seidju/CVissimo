//
//  ChatViewDataSource.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import DeepDiff
import AsyncDisplayKit

private enum CellVerticalEdge {
  case top
  case bottom
}

private struct DiffAwareItem: DiffAware {
  var diffId: Int
  init(chatItem: ChatBaseMessage) {
    diffId = Int(chatItem.messageId)
  }

  static func compareContent(_ a: DiffAwareItem, _ b: DiffAwareItem) -> Bool {
    return true
  }
}

protocol ChatViewDataSourceDelegate: class {
  func didScrollCloseToTop()
  func didScrollCloseToBottom()
}

class ChatViewDataSource: NSObject {
  weak var delegate: ChatViewDataSourceDelegate?

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
    autoLoadMoreContentIfNeeded()
    print("is close to bottom: \(isCloseToBottom())")
    print("is close to top: \(isCloseToTop())")
  }
}

extension ChatViewDataSource {

  private func autoLoadMoreContentIfNeeded() {
    if isCloseToTop() {
      delegate?.didScrollCloseToTop()
    } else if isCloseToBottom() {
      delegate?.didScrollCloseToBottom()
    }
  }

  private func isScrolledAtBottom() -> Bool {
    guard collectionNode.numberOfSections > 0 && collectionNode.numberOfItems(inSection: 0) > 0 else { return true }
    let sectionIndex = collectionNode.numberOfSections - 1
    let itemIndex = collectionNode.numberOfItems(inSection: sectionIndex) - 1
    let lastIndexPath = IndexPath(item: itemIndex, section: sectionIndex)
    return isIndexPathVisible(lastIndexPath, atEdge: .bottom)
  }

  private func isScrolledAtTop() -> Bool {
    guard collectionNode.numberOfSections > 0 && collectionNode.numberOfItems(inSection: 0) > 0 else { return true }
    let firstIndexPath = IndexPath(item: 0, section: 0)
    return isIndexPathVisible(firstIndexPath, atEdge: .top)
  }

  private func isCloseToTop() -> Bool {
    guard collectionNode.view.contentSize.height > 0 else { return true }
    return (visibleRect().maxY / collectionNode.view.contentSize.height) > (1 - Constants.autoloadingFractionalThreshold)
  }

  private func isCloseToBottom() -> Bool {
    guard collectionNode.view.contentSize.height > 0 else { return true }
    return (visibleRect().minY / collectionNode.view.contentSize.height) < Constants.autoloadingFractionalThreshold
  }

  private func isIndexPathVisible(_ indexPath: IndexPath, atEdge edge: CellVerticalEdge) -> Bool {
    guard let attributes = collectionNode.collectionViewLayout.layoutAttributesForItem(at: indexPath) else { return false }
    let visibleRect = self.visibleRect()
    let intersection = visibleRect.intersection(attributes.frame)
    if edge == .top {
      return abs(intersection.minY - attributes.frame.minY) < Constants.epsilon
    } else {
      return abs(intersection.maxY - attributes.frame.maxY) < Constants.epsilon
    }
  }

  private func visibleRect() -> CGRect {
    let contentInset = collectionNode.contentInset
    let collectionViewBounds = collectionNode.bounds
    let contentSize = collectionNode.collectionViewLayout.collectionViewContentSize
    return CGRect(x: CGFloat(0), y: collectionNode.contentOffset.y + contentInset.top, width: collectionViewBounds.width, height: min(contentSize.height, collectionViewBounds.height - contentInset.top - contentInset.bottom))
  }
}

extension ChatViewDataSource {
  private enum Constants {
    static let autoloadingFractionalThreshold: CGFloat = 0.05 // in [0, 1]
    static let epsilon: CGFloat = 0.001
  }
}
