//
//  KeyValueStorageTests.swift
//  CVissimoTests
//
//  Created by Pavel Shatalov on 17/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import XCTest
@testable import CVissimo

class UserDefaultsStorageTests: XCTestCase {

  private let storage: KeyValueStorage = UserDefaultsStorage()

  override func setUp() {
  }

  override func tearDown() {
  }

  func testSaveValueForKey() {
    XCTAssertNoThrow(try storage.save(value: "some", for: "key"))
  }

  func testLoadValueForKey() {
    let uniqueKey = UUID().uuidString.lowercased()
    let someValue = "some"
    try? storage.save(value: someValue, for: uniqueKey)
    do {
      if let object = try storage.loadValue(for: uniqueKey) as? String {
        XCTAssertEqual(object, someValue)
      } else {
        XCTFail("Fetched object is invalid")
      }
    } catch {
      XCTFail("Object for key not found")
    }
  }
}
