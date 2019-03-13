//
//  BaseXibView.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import UIKit

class BaseXibView: UIView {

  @IBOutlet var contentView: UIView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
    configure()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
    configure()
  }

  func loadViewFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
    return view
  }

  func xibSetup() {
    contentView = loadViewFromNib()
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(contentView)
  }

  func configure() {
    fatalError("Override in subclass")
  }

}
