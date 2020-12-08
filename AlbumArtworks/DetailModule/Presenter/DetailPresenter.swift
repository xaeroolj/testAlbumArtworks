//
//  DetailPresenter.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 07.12.2020.
//

import Foundation

protocol DetailViewPresenterProtocol: AnyObject {

    var album: AlbumDetailModelProtocol? {get set}

    init(view: DetailViewProtocol,
         dataServise: MediaServiseProtocolForDetailViewProtocol,
         router: RouterProtocol,
         album: AlbumDetailModelProtocol)

    func initData()
    func getAlbum(forID albumID: Int)
    func reloadData()
}

final class DetailPresenter: DetailViewPresenterProtocol {

    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    let dataServise: MediaServiseProtocolForDetailViewProtocol!

    private let requestedAlbum: Int!

    var album: AlbumDetailModelProtocol?

    required init(view: DetailViewProtocol,
                  dataServise: MediaServiseProtocolForDetailViewProtocol,
                  router: RouterProtocol,
                  album: AlbumDetailModelProtocol) {
        self.view = view
        self.router = router
        self.dataServise = dataServise
        self.requestedAlbum = album.collectionId
        self.album = album
    }

    func initData() {
        view?.viewLoad()
        self.getAlbum(forID: requestedAlbum)

    }

    func getAlbum(forID albumID: Int) {
        if albumID == 0 {
            view?.showError(.notFound)
        }
        view?.loading()

        dataServise.getAlbumTracksFor(albumId: albumID) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                do {
                    let mediaArray = try result.get().mediaArray
                    if !mediaArray.isEmpty {
                        self.album?.addTracks(from: mediaArray)
                        self.view?.updateView()
                    } else {
                        self.view?.showError(.notFound)
                    }
                } catch {
                    if let error = error as? NetworkError {
                        self.view?.showError(error)
                    }
                }
            }
        }
    }

    func reloadData() {

    }

}
