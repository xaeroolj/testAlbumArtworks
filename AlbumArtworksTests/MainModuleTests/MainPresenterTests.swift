//
//  MainPresenterTests.swift
//  AlbumArtworksTests
//
//  Created by Roman Trekhlebov on 09.12.2020.
//

import XCTest
@testable import AlbumArtworks

class MainPresenterTests: XCTestCase {

    var view: MockView!
    var sut: MainPresenter!
    var dataServise: MediaServiseProtocolForMainViewProtocol!
    var router: RouterProtocol!

    override func setUpWithError() throws {
        let navC = UINavigationController()
        let assamblyB = AssemblyModuleBuilder()
        router = Router(navigationController: navC, assemblyBuilder: assamblyB)
    }

    override func tearDownWithError() throws {
        view = nil
        dataServise = nil
        sut = nil //presenter
        router = nil
    }

    func testMainPeresenter_GetAlbums() throws {

        let media = Media(wrapperType: .collection, artistName: "foo", collectionName: "bar", collectionId: 1, artistViewURL: "url", collectionViewURL: nil, artworkUrl60: nil, artworkUrl100: nil, trackName: nil, collectionPrice: nil, collectionExplicitness: "foo", trackCount: 1, copyright: nil, country: "FOO", releaseDate: "bar", contentAdvisoryRating: "foo", trackNumber: nil, trackTimeMillis: 1, tracks: nil)
        let mediaResponse = (MediaResponse(resultCount: 1, mediaArray: [media]))

        view = MockView()
        dataServise = MockMainDataService(response: mediaResponse)
        sut = MainPresenter(view: view, dataServise: dataServise, router: router)

        //positive
        sut.getAlbums(for: "foo")
        wait(for: [
                view.viewUpdateExpectation,
                view.viewLoadingExpectation], timeout: 2.0)
    }

    func testMainPeresenter_GetAlbumsErrorCalled() throws {

        view = MockView()
        dataServise = MockMainDataService()
        sut = MainPresenter(view: view, dataServise: dataServise, router: router)

        sut.getAlbums(for: "foo")

        wait(for: [view.viewShowErrorExpectation], timeout: 2.0)
    }
}
