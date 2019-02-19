//
//  KeyValueStorage.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 17/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

protocol KeyValueStorage {

  func save(value: Any, for key: String) throws
  func loadValue(for key: String) throws -> Any

}
