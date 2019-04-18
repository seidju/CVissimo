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

  private let coreFactory = CoreFactory()
  private var storage: KeyValueStorage!

  override func setUp() {
    storage = coreFactory.makeUserDefaultsStorage()
  }

  override func tearDown() {
  }

}
