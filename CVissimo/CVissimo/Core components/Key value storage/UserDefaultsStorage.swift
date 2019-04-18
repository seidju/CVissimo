//
//  UserDefaultsStorage.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 18/04/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

final class UserDefaultsStorage: KeyValueStorage {
  
  private let defaults = UserDefaults.standard
  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()

  func save<T: Encodable>(value: T, for key: String) throws  {
    let data = try encoder.encode(value)
    defaults.set(data, forKey: key)
  }
  
  func loadValue<T: Decodable>(for key: String) throws -> T {
    guard let data = defaults.object(forKey: key) as? Data else {
      throw KeyValueStorageError.objectNotFound
    }
    return try decoder.decode(T.self, from: data)
  }
  
}
