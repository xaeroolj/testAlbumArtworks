//
//  MainPresenter.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 03.12.2020.
//

import Foundation

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol)
}

final class MainPresenter: NSObject, MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    required init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
}
