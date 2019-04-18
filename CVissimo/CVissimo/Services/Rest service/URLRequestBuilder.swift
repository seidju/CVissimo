//
//  URLRequestBuilder.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 18/04/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation


extension RestServiceImp { internal enum RequestBuilder {} }

extension RestServiceImp.RequestBuilder {

  private enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
  }

  static var baseUrl: URL {
    return URL(string: "www.google.com")!
  }

  static func userIdRequest(for phone: String) -> URLRequest? {
    var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)

    urlComponents?.queryItems = [
      URLQueryItem(name: "phone", value: phone)
    ]

    guard let finalUrl = urlComponents?.url else {
      return nil
    }

    var urlRequest = URLRequest(url: finalUrl)
    urlRequest.httpMethod = RequestMethod.get.rawValue
    return urlRequest
  }

}
