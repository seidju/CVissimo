//
//  UIImageExtensions.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 12/03/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import UIKit

extension UIImage {
  func tintWithColor(_ color: UIColor) -> UIImage {
    let rect = CGRect(origin: CGPoint.zero, size: self.size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, self.scale)
    let context = UIGraphicsGetCurrentContext()!
    color.setFill()
    context.fill(rect)
    self.draw(in: rect, blendMode: .destinationIn, alpha: 1)
    let image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image.resizableImage(withCapInsets: self.capInsets)
  }

  func blendWithColor(_ color: UIColor) -> UIImage {
    let rect = CGRect(origin: CGPoint.zero, size: self.size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
    let context = UIGraphicsGetCurrentContext()!
    context.translateBy(x: 0, y: rect.height)
    context.scaleBy(x: 1.0, y: -1.0)
    context.setBlendMode(.normal)
    context.draw(self.cgImage!, in: rect)
    context.clip(to: rect, mask: self.cgImage!)
    color.setFill()
    context.addRect(rect)
    context.drawPath(using: .fill)
    let image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image.resizableImage(withCapInsets: self.capInsets)
  }

  static func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
    let rect = CGRect(origin: CGPoint.zero, size: size)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
  }
}
