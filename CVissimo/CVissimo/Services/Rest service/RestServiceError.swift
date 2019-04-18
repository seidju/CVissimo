//
//  RestServiceError.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 18/04/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

enum RestServiceError: LocalizedError {
  
  case noInternetConnection
  case taskCanceled
  case authorizationRequired
  case cantParseResponse
  case unexpectedAnswer
  case internalServerError
  case other
  
}
