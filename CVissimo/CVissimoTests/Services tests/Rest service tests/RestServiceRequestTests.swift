//
//  RestServiceRequestTests.swift
//  CVissimoTests
//
//  Created by Pavel Shatalov on 18/04/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import XCTest
@testable import CVissimo

class RestServiceRequestTests: XCTestCase {

  var restService: RestService!
  var serviceFactory = ServiceFactory(coreFactory: CoreFactory())
  override func setUp() {
    restService = serviceFactory.makeRestService()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  private func buildResponse(statusCode: Int, parameters: [String: Any], urlError: URLError? = nil) -> RestService.Response? {
    do {
      let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      let urlResponse = HTTPURLResponse(url: URL(string: "ya.ru")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
      return (data, urlResponse, urlError)
    } catch {
      return nil
    }
  }

  func testNoConnectionError() {
    let error = NSError(domain: "Timeout", code: URLError.timedOut.rawValue, userInfo: nil)
    let response = RestService.Response(nil, nil, error)
    XCTAssertThrowsError(try restService.validateResponse(response), "Timeout error thrown") { (error) in
      if let apiError = error as? RestServiceError,
        case .noInternetConnection = apiError {
        return
      } else {
        XCTFail("Error code is wrong")
      }
    }
  }

  func testSuccessResponse () {
    guard let validUrlResponse = buildResponse(statusCode: 200,
                                               parameters: ["userId": UUID().uuidString.lowercased(), "status": "new"],
                                               urlError: nil) else {
      XCTFail("Response builder failed")
      return
    }

    XCTAssertNoThrow(try restService.validateResponse(validUrlResponse))
    let session = URLSessionMock(with: validUrlResponse)
    restService.urlSession = session
    let expect = expectation(description: "wait for result")
    _ = restService.requestUserId(for: "+79082116100") { (result) in
      switch result {
      case .success:
        expect.fulfill()

      case .failure:
        XCTFail("Request failed!")
      }
    }
    wait(for: [expect], timeout: 1.0)
  }

}
