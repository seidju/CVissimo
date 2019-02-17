//
//  DeepLinkOption.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 17/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

enum DeepLinkOption {

  case unknown

  static func build(with url: URL) -> DeepLinkOption? {
    return nil
  }
}
