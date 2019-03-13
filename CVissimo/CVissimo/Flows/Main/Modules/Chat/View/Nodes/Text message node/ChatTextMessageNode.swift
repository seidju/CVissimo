//
//  ChatTextMessageNode.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import AsyncDisplayKit

class ChatTextMessageNode: ASCellNode {
  private lazy var textNode: ASTextNode = {
    let textNode = ASTextNode()
    textNode.displaysAsynchronously = false
    textNode.isLayerBacked = true
    return textNode
  }()

  private let bubbleNode: ASImageNode = ASImageNode()
  private var isIncoming: Bool = false

  init(with message: ChatBaseMessage, isIncoming: Bool) {
    super.init()
    self.isIncoming = isIncoming
    if case let (.text(text)) = message.type {
      textNode.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0, weight: .medium)])
    }
    let bubbleImage = isIncoming ? UIImage(named: "bubble-incoming-tail")?.tintWithColor(.lightGray) : UIImage(named: "bubble-outgoing-tail")?.tintWithColor(.blue)
    bubbleNode.image = bubbleImage
    addSubnode(bubbleNode)
    addSubnode(textNode)
  }

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let insets = isIncoming ? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32) : UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
    let textInsetLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8.0, left: isIncoming ? 16.0 : 8.0, bottom: 8.0, right: isIncoming ? 8.0 : 16.0), child: textNode)
    let overlay = ASBackgroundLayoutSpec(child: textInsetLayout, background: bubbleNode)
    let relativeSpec = ASRelativeLayoutSpec(horizontalPosition: isIncoming ? .start : .end, verticalPosition: .center, sizingOption: [], child: overlay)
    return ASInsetLayoutSpec(insets: insets, child: relativeSpec)
  }

}
