//
//  MainPresenter.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 03.12.2020.
//

import Foundation

protocol MainViewPresenterProtocol: AnyObject {

    var albumsArray: [AlbumMainModelProtocol]? {get set}

    init(view: MainViewProtocol, dataServise: MediaServiseProtocolForMainViewProtocol, router: RouterProtocol)

    var lastTerm: String! {get set}

    func getAlbums(for term: String)
    func tapOnAlbum(album: AlbumMainModelProtocol)
    func reloadData()
}

// MARK: - MainPresenter
final class MainPresenter: NSObject {

    // MARK: - Public Properties
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    let dataServise: MediaServiseProtocolForMainViewProtocol!

    var albumsArray: [AlbumMainModelProtocol]?
    var lastTerm: String!

    // MARK: - Initializers
    required init(view: MainViewProtocol,
                  dataServise: MediaServiseProtocolForMainViewProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.router = router
        self.dataServise = dataServise
    }
}

// MARK: - MainViewPresenterProtocol
extension MainPresenter: MainViewPresenterProtocol {
    func reloadData() {
        guard let term = self.lastTerm else { return }
        lastTerm = ""
        getAlbums(for: term)
    }

    func tapOnAlbum(album: AlbumMainModelProtocol) {
        guard let detailAlbum = album as? AlbumDetailModelProtocol else { return }
        router?.showDetail(album: detailAlbum)
    }

    func getAlbums(for term: String) {

        if term == lastTerm { return }

        NSObject.cancelPreviousPerformRequests(withTarget: self)

        if term.isEmpty {
            self.albumsArray?.removeAll()
            self.view?.viewLoad()
            return
        }

        self.lastTerm = term
        self.albumsArray?.removeAll()
        view?.loading()

        //request with delay
        perform(#selector(delayedRequest(_:)), with: term, afterDelay: 0.5)
    }

    @objc private func delayedRequest(_ term: String) {
        dataServise.getMediaFor(term: term) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                do {
                    let mediaArray = try result.get().mediaArray
                    if !mediaArray.isEmpty {
                        let sortedArray = mediaArray.sorted { itemA, itemB in
                            itemA.albumName < itemB.albumName
                        }
                        self.albumsArray = sortedArray
                        self.view?.updateView()
                    } else {
                        self.albumsArray?.removeAll()
                        self.view?.showError(.notFound)
                    }
                } catch {
                    self.albumsArray?.removeAll()
                    if let error = error as? NetworkError {
                        self.view?.showError(error)
                    }
                }
            }
        }
    }
}
