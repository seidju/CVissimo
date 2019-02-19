//
//  UserDefaultsStorage.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 19/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

class UserDefaultsStorage: KeyValueStorage {

  private let defaults = UserDefaults.standard

  func save(value: Any, for key: String) throws {
    defaults.set(value, forKey: key)
    defaults.synchronize()
  }

  func loadValue(for key: String) throws -> Any {
    if let object = defaults.object(forKey: key) {
      return object
    } else {
      throw KeyValueStorageError.objectNotFound
    }
  }

}
