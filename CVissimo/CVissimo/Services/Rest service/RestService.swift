//
//  RestService.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 18/04/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation


protocol RestService {

  typealias Response = (data: Data?, response: URLResponse?, error: Error?)

  var urlSession: URLSession { get set }

  func validateResponse(_ response: Response) throws

  //put API methods signature in here
  func requestUserId(for phone: String, completion: @escaping (Result<UserResponse, Error>) -> Void) -> Cancellable?
}
