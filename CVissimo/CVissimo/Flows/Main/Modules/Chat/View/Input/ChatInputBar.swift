//
//  ChatInputBar.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import UIKit

protocol ChatInputBarDelegate: class {
  func didPressSendMessageWith(_ text: String)
}

final class ChatInputBar: UIView {
  weak var delegate: ChatInputBarDelegate?

  static func getView() -> ChatInputBar? {
    let nib = ChatInputBar.nib()
    if let view = nib?.instantiate(withOwner: self, options: nil).first as?
      ChatInputBar {
      view.sendButton.isEnabled = false
      view.textView.textColor = .black
      view.textView.placeholder = "Enter message..."
      view.textView.delegate = view.self
      return view
    } else {
      return nil
    }
  }

  @IBOutlet private weak var sendButton: UIButton!
  @IBOutlet private weak var textView: PlaceholderTextView!

  override var intrinsicContentSize: CGSize {
    textView.isScrollEnabled = false
    let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat(MAXFLOAT)))
    let totalHeight = size.height + Constants.paddingTop + Constants.paddingBottom
    if totalHeight <= Constants.maxHeight {
      return CGSize(width: bounds.width, height: max(totalHeight, Constants.minHeight))
    } else {
      self.textView.isScrollEnabled = true
      return CGSize(width: bounds.width, height: Constants.maxHeight)
    }
  }

  @IBAction private func sendMessagePressed(_ sender: Any) {
    delegate?.didPressSendMessageWith(textView.text)
    textView.text = ""
    updateLayout()
    evaluateInputState()
  }

  private func evaluateInputState() {
    sendButton.isEnabled = !textView.text.isEmpty
  }

  private func updateLayout() {
    invalidateIntrinsicContentSize()
    updateConstraints()
  }
}

extension ChatInputBar: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    updateLayout()
    evaluateInputState()
  }
}

extension ChatInputBar: NibLoadable {
  static var NibName: String {
    return "ChatInputBar"
  }
}

extension ChatInputBar {
  private enum Constants {
    static let maxHeight: CGFloat = 125.0
    static let minHeight: CGFloat = 49.0
    static let paddingTop: CGFloat = 8.0
    static let paddingBottom: CGFloat = 8.0
    static let placeholderText: String = "Enter message..."
  }
}

protocol NibLoadable {
  static var NibName: String { get }
}

extension NibLoadable {
  static func nib() -> UINib? {
    if NibName.count > 0 {
      return UINib(nibName: NibName, bundle: nil)
    } else {
      return nil
    }
  }
}
