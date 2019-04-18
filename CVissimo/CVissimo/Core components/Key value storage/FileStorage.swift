//
//  FileStorage.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 18/04/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

final class FileStorage: KeyValueStorage {
  private let jsonDecoder = JSONDecoder()
  private let jsonEncoder = JSONEncoder()

  private func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
  }

  func loadValue<T: Decodable>(for key: String) throws -> T {
    let restoreUrl = getDocumentsDirectory().appendingPathComponent(key)
    let data = try Data(contentsOf: restoreUrl)
    let state = try JSONDecoder().decode(T.self, from: data)
    return state
  }

  func save<T: Encodable>(value: T, for key: String) throws {
    let data = try jsonEncoder.encode(value)
    let saveUrl = getDocumentsDirectory().appendingPathComponent(key)
    try data.write(to: saveUrl)
  }
}
