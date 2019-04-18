//
//  RestServiceParsingTests.swift
//  CVissimoTests
//
//  Created by Pavel Shatalov on 18/04/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import XCTest
@testable import CVissimo

class RestServiceParsingTests: XCTestCase {

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testUserResponseSuccessParsing() {
    let responseJson: [String: Any] = ["userId": UUID().uuidString.lowercased(), "status": "registered"]
    do {
      let rawData = try JSONSerialization.data(withJSONObject: responseJson, options: .prettyPrinted)
      XCTAssertNoThrow(try JSONDecoder().decode(UserResponse.self, from: rawData))
    } catch {
      XCTFail("Test json data is incorrect!")
    }
  }

}
