//
//  RestServiceImp.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 18/04/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

struct RestServiceImp: RestService {

  var urlSession = URLSession(configuration: .default)

  func requestUserId(for phone: String, completion: @escaping (Result<UserResponse, Error>) -> Void) -> Cancellable? {
    guard let request = RequestBuilder.userIdRequest(for: phone) else {
      completion(.failure(RestServiceError.cantParseResponse))
      return nil
    }
    return performRequest(urlRequest: request, completion: completion)
  }

  func validateResponse(_ response: RestService.Response) throws {
    printResponse(response)
    try checkURLError(response: response)
    if let httpResponse = response.response as? HTTPURLResponse {
      switch httpResponse.statusCode {
      case 200...226, 301...308:
        break

      case 400...404:
        throw RestServiceError.authorizationRequired
        
      case 500...:
        throw RestServiceError.internalServerError
        
      default:
        break
      }
    }
  }

  private func checkURLError(response: Response) throws {
    if let error = response.error {
      if (error as NSError).code == URLError.cancelled.rawValue {
        throw RestServiceError.taskCanceled
      }
      throw RestServiceError.noInternetConnection
    }
  }

  private func performRequest<T: Decodable>(urlRequest: URLRequest,
                                            completion: @escaping (Result<T, Error>) -> Void) -> Cancellable? {
    urlRequest.printSelf()
    let task = urlSession.dataTask(with: urlRequest) { data, response, error  in
      do {
        try self.validateResponse((data, response, error))
        guard let data = data else {
          completion(.failure(RestServiceError.other))
          return
        }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try jsonDecoder.decode(T.self, from: data)
        completion(.success(result))
      } catch {
        completion(.failure(error))
      }
    }
    task.resume()
    return task
  }

}

extension RestServiceImp {
  private func printResponse(_ response: Response) {
    var description: String
    description = "\n********** URL response **********"
    if let urlResponse = response.response {
      description += "\nURL: " + (urlResponse.url?.absoluteString ?? "nil")
      if let httpResponse = urlResponse as? HTTPURLResponse {
        description += "\nStatus Code: \(httpResponse.statusCode)"
        if let headers = httpResponse.allHeaderFields as? [String: Any], !headers.isEmpty {
          description += "\nHeaders:"
          headers.forEach { header in
            description += "\n         " + header.key + ": " + String(describing: header.value)
          }
        }
      }
    }
    
    if let body = response.data {
      if let json = try? JSONSerialization.jsonObject(with: body, options: .allowFragments) as? [String: Any] {
        description += "\nBody: " + json.debugDescription
      } else if !body.isEmpty {
        description += "\nBody: " + (String(bytes: body, encoding: .utf8) ?? body.debugDescription)
      }
    }
    if let urlError = response.error {
      description += "\nUrl Error: \(urlError)"
    }
    description += "\n*********************************\n\n"
    print(description)
  }
}

extension URLRequest {
  func printSelf() {
    var description = "\n********** URL request **********"
    description += "\nURL: " + (self.url?.absoluteString ?? "nil")
    description += "\nMethod: " + (self.httpMethod ?? "nil")
    
    if let headers = allHTTPHeaderFields, !headers.isEmpty {
      description += ("\nHeaders: ")
      self.allHTTPHeaderFields?.forEach{description += "\n        " + $0 + ": " + $1}
    }
    
    if let body = self.httpBody {
      if let json = try? JSONSerialization.jsonObject(with: body, options: .allowFragments) as? [String: Any] {
        description += "\nBody: " + json.debugDescription
      } else if !body.isEmpty {
        description += "\nBody: " + (String(bytes: body, encoding: .utf8) ?? body.debugDescription)
      }
    }
    description += ("\n*********************************\n\n")
    print(description)
  }
}

