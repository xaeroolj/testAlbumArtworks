//
//  AppDelegate.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 03.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: - Window init
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let assemblyBuilder = AssemblyModuleBuilder()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        window?.rootViewController = navigationController
//        router.initialViewController()
        router.showDetail(album: "331790882")
        window?.makeKeyAndVisible()
        return true
    }
}
