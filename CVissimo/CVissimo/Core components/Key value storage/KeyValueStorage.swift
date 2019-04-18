//
//  KeyValueStorage.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 17/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

protocol KeyValueStorage {

  func save<T: Encodable>(value: T, for key: String) throws
  func loadValue<T: Decodable>(for key: String) throws -> T

}
