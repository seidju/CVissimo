//
//  ChatViewOutput.swift
//  CVissimo
//
//  Created Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import Foundation

protocol ChatViewOutput {

  func viewDidLoad()
  func didPressSendTextButton(_ text: String)

}
