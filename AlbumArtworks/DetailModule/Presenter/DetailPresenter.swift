//
//  DetailPresenter.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 07.12.2020.
//

import Foundation

protocol DetailViewPresenterProtocol: AnyObject {

    init(view: DetailViewProtocol, dataServise: MediaServiseProtocolForDetailViewProtocol, router: RouterProtocol)
}

final class DetailPresenter: NSObject, DetailViewPresenterProtocol {

    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    let dataServise: MediaServiseProtocolForDetailViewProtocol!

    required init(view: DetailViewProtocol,
                  dataServise: MediaServiseProtocolForDetailViewProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.router = router
        self.dataServise = dataServise
    }
}
