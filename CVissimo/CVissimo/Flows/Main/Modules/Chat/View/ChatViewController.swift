//
//  ChatViewController.swift
//  CVissimo
//
//  Created Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ChatViewController: ASViewController<ASCollectionNode> {

  var output: ChatViewOutput?
  private let collectionNode: ASCollectionNode

  private lazy var inputBar: ChatInputBar? = {
    let inputBar = ChatInputBar.getView()
    inputBar?.delegate = self
    return inputBar
  }()

  private lazy var dataSource: ChatViewDataSource = {
    let dataSource = ChatViewDataSource(collectionNode: collectionNode)
    dataSource.delegate = self
    return dataSource
  }()

  private let notificationCenter = NotificationCenter.default

  init() {
    collectionNode = ASCollectionNode(collectionViewLayout: UICollectionViewFlowLayout())//ChatBouncyLayout(style: .regular))
    collectionNode.inverted = true
    super.init(node: collectionNode)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override var inputAccessoryView: UIView? {
    return inputBar
  }

  override var canBecomeFirstResponder: Bool {
    return true
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionNode()
    setupKeyboardTracking()
    output?.viewDidLoad()
  }

  private func configureCollectionNode() {
    collectionNode.view.keyboardDismissMode = .interactive
    collectionNode.allowsSelection = false
    collectionNode.alwaysBounceVertical = true
    collectionNode.showsVerticalScrollIndicator = true
    collectionNode.showsHorizontalScrollIndicator = false
  }

  private func setupKeyboardTracking() {
    notificationCenter.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notif in
      if let keyboardFrame = notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
        let keyboardHeight = keyboardFrame.cgRectValue.height
        self?.collectionNode.contentInset = UIEdgeInsets(top: keyboardHeight - (self?.inputBar?.bounds.height ?? 0.0),
                                                         left: 0.0, bottom: self!.view.safeAreaInsets.top, right: 0.0)
      }
    }

    notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notif in
      self?.collectionNode.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: self!.view.safeAreaInsets.top, right: 0.0)
    }
  }
}

extension ChatViewController: ChatViewInput {

  func update(messages: [ChatBaseMessage]) {
    dataSource.reload(with: messages)
  }
}

extension ChatViewController: ChatInputBarDelegate {
  func didPressSendMessageWith(_ text: String) {
    output?.didPressSendTextButton(text)
  }
}

extension ChatViewController: ChatViewDataSourceDelegate {
  func didScrollCloseToBottom() {
    output?.didScrollCloseToBottom()
  }

  func didScrollCloseToTop() {
    output?.didScrollCloseToTop()
  }
}
