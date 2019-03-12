//
//  CoreFactory.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 19/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

struct CoreFactory {

  func makeUserDefaultsStorage() -> KeyValueStorage {
    return UserDefaultsStorage()
  }

}
