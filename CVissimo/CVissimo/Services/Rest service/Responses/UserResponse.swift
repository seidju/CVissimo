//
//  UserResponse.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 18/04/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

struct UserResponse: Decodable {

  let userId: String
  let status: Status

  enum Status: String, Decodable {
    case new
    case registered
  }

}
