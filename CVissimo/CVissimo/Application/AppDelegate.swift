//
//  AppDelegate.swift
//  CVissimo
//
//  Created by Pavel Shatalov on 17/02/2019.
//  Copyright © 2019 Pavel Shatalov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  private let rootController: UINavigationController = UINavigationController()
  private lazy var applicaitonCoordinator: ApplicationCoordinator = {
    let router = BaseRouter(rootController: rootController)
    let coordinator = ApplicationCoordinator(router: router)
    return coordinator
  }()

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setupWindow()
    applicaitonCoordinator.start()
    return true
  }

  private func setupWindow() {
    let window = UIWindow()
    window.backgroundColor = .black
    window.rootViewController = rootController
    window.makeKeyAndVisible()
    self.window = window
  }
}
