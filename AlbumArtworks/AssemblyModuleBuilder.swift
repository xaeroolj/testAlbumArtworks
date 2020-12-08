//
//  AssemblyModuleBuilder.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 03.12.2020.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(album: AlbumDetailModelProtocol, router: RouterProtocol) -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let dataServise = MediaServise()
        let presenter = MainPresenter(view: view,
                                      dataServise: dataServise,
                                      router: router)
        view.presenter = presenter
        return view
    }
    func createDetailModule(album: AlbumDetailModelProtocol, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let dataServise = MediaServise()
        let presenter = DetailPresenter(view: view,
                                      dataServise: dataServise,
                                      router: router,
                                      album: album)
        view.presenter = presenter
        return view
    }
}
