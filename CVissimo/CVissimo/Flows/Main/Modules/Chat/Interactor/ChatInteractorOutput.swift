//
//  ChatInteractorOutput.swift
//  CVissimo
//
//  Created Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

protocol ChatInteractorOutput: class {

  func didObtainInitialMessages(_ messages: [ChatBaseMessage])
  func didObtainMessages(_ messages: [ChatBaseMessage], isBackward: Bool, hasMore: Bool)

}
