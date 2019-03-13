//
//  ChatBaseNode.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import AsyncDisplayKit

class ChatBaseMessageNode: ASCellNode {

  private lazy var contentNode: ASDisplayNode = {
    let contentNode = ASDisplayNode()
    contentNode.displaysAsynchronously = false
    contentNode.isLayerBacked = true
    return contentNode
  }()

  init(isIncoming: Bool) {
    super.init()
    let imageNode = ASImageNode()
    imageNode.image = isIncoming ? UIImage(named: "bubble-incoming-tail") : UIImage(named: "bubble-outgoing-tail")
    addSubnode(contentNode)
    contentNode.addSubnode(imageNode)
  }

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let mainInsetSpect = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8.0, left: 15.0, bottom: 8.0, right: 15.0), child: contentNode)
    return ASWrapperLayoutSpec(layoutElement: mainInsetSpect)
  }

  override func didLoad() {
    super.didLoad()
  }

  override func layout() {
    super.layout()
  }
}
