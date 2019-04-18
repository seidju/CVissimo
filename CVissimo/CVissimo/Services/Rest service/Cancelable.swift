//
//  Cancelable.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 18/04/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

protocol Cancellable {
  func cancel()
}

extension URLSessionTask: Cancellable { }
