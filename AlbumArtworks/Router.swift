//
//  Router.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 03.12.2020.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(album: String)
    func popToRoot()
}

final class Router: RouterProtocol {

    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    init(navigationController: UINavigationController,
         assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    func showDetail(album: String) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailModule(albumID: album,
                                                                                 router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
