//
//  UrlSession.swift
//  CVissimoTests
//
//  Created by Pavel Shatalov on 18/04/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation
@testable import CVissimo

class URLSessionDataTaskMock: URLSessionDataTask {
  private let closure: () -> Void

  init(closure: @escaping () -> Void) {
    self.closure = closure
  }

  override func resume() {
    closure()
  }
}

class URLSessionMock: URLSession {
  typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

  init(with response: RestServiceImp.Response) {
    self.data = response.data
    self.error = response.error
    self.urlResponse = response.response
  }

  var data: Data?
  var error: Error?
  var urlResponse: URLResponse?

  override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    let data = self.data
    let error = self.error
    let response = self.urlResponse

    return URLSessionDataTaskMock {
      completionHandler(data, response, error)
    }
  }
}
