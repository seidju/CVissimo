//
//  BaseView.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 17/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import UIKit

protocol BaseView: NSObjectProtocol, Presentable { }

extension UIViewController: BaseView { }
