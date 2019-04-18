//
//  PlaceholderTextView.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import UIKit

final class PlaceholderTextView: UITextView {

  private let placeholderLabel = UILabel()

  private var currentInputTextViewHeight: CGFloat = 32

  var placeholder: String = "" {
    didSet {
      placeholderLabel.text = placeholder
    }
  }

  override var font: UIFont! {
    didSet {
      if placeholderFont == nil {
        placeholderLabel.font = font
      }
    }
  }

  override var contentSize: CGSize {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }

  var placeholderFont: UIFont? {
    didSet {
      placeholderLabel.font = placeholderFont ?? self.font
    }
  }

  override var textAlignment: NSTextAlignment {
    didSet {
      placeholderLabel.textAlignment = textAlignment
    }
  }

  override var text: String! {
    didSet {
      textDidChange()
    }
  }

  override var attributedText: NSAttributedString! {
    didSet {
      textDidChange()
    }
  }

  override var textContainerInset: UIEdgeInsets {
    didSet {
      updateConstraintsForPlaceholderLabel()
    }
  }

  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(textDidChange),
                                           name: UITextView.textDidChangeNotification,
                                           object: nil)
    placeholderLabel.translatesAutoresizingMaskIntoConstraints = false

    addSubview(placeholderLabel)

    updateConstraintsForPlaceholderLabel()
  }

  private func updateConstraintsForPlaceholderLabel() {
    let placeholderConstraints = constraints.filter({ $0.firstItem as? NSObject == placeholderLabel })
    removeConstraints(placeholderConstraints)
    addConstraints(
      [
        placeholderLabel.leftAnchor.constraint(
          equalTo: leftAnchor, constant: textContainerInset.left + Constants.Margin.leadingPlaceholderLabel
        ),
        placeholderLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: textContainerInset.right),
        placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: textContainerInset.top),
        placeholderLabel.heightAnchor.constraint(equalToConstant: Constants.heightPlaceholderLabel)
      ]
    )
  }

  @objc private func textDidChange() {
    placeholderLabel.isHidden = !text.isEmpty
  }

  override var intrinsicContentSize: CGSize {
    return CGSize(width: bounds.width,
                  height: min((Constants.defaultInputTextViewHeight) * Constants.magnificationFactor,
                              currentInputTextViewHeight))
  }

  func setContentHeight() {
    let inputTextViewHeight = sizeThatFits(CGSize(width: frame.width, height: frame.height)).height

    if inputTextViewHeight != currentInputTextViewHeight {
      if isInputTextViewMaxHeight(contentHeight: inputTextViewHeight) {
        isScrollEnabled = true
      } else {
        isScrollEnabled = false
        invalidateIntrinsicContentSize()
      }
    }
    if inputTextViewHeight > Constants.defaultInputTextViewHeight {
      currentInputTextViewHeight =  inputTextViewHeight
    } else {
      currentInputTextViewHeight = Constants.defaultInputTextViewHeight
    }

  }

  private func isInputTextViewMaxHeight(contentHeight: CGFloat) -> Bool {
    if (Constants.defaultInputTextViewHeight * Constants.magnificationFactor) > contentHeight {
      return false
    }
    return true
  }
}

extension PlaceholderTextView {

  private enum Constants {
    enum Margin {
      static let leadingPlaceholderLabel: CGFloat = 4
    }
    static let defaultInputTextViewHeight: CGFloat = 32
    static let heightPlaceholderLabel: CGFloat = 20
    static let magnificationFactor: CGFloat = 4
  }

}
