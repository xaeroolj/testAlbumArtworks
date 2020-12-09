//
//  DetailPresenterTests.swift
//  AlbumArtworksTests
//
//  Created by Roman Trekhlebov on 09.12.2020.
//

import XCTest
@testable import AlbumArtworks

class DetailPresenterTests: XCTestCase {

    var view: MockView!
    var sut: DetailPresenter!
    var dataServise: MediaServiseProtocolForDetailViewProtocol!
    var router: RouterProtocol!
    var album: Media!

    override func setUpWithError() throws {
        let navC = UINavigationController()
        let assamblyB = AssemblyModuleBuilder()
        router = Router(navigationController: navC, assemblyBuilder: assamblyB)
        album = Media(wrapperType: .collection, artistName: "foo", collectionName: "bar", collectionId: 1, artistViewURL: "url", collectionViewURL: nil, artworkUrl60: nil, artworkUrl100: nil, trackName: nil, collectionPrice: nil, collectionExplicitness: "foo", trackCount: 1, copyright: nil, country: "FOO", releaseDate: "bar", contentAdvisoryRating: "foo", trackNumber: nil, trackTimeMillis: 1, tracks: nil)

    }

    override func tearDownWithError() throws {
        view = nil
        dataServise = nil
        sut = nil //presenter
        router = nil
        album = nil
    }

    func testDetailPeresenter_GetAlbum() throws {

        let mediaResponse = (MediaResponse(resultCount: 1, mediaArray: [album]))

        view = MockView()
        dataServise = MockDetailDataService(response: mediaResponse)
        sut = DetailPresenter(view: view, dataServise: dataServise, router: router, album: album)

        sut.getAlbum(forID: 1)
        wait(for: [
                view.viewUpdateExpectation,
                view.viewLoadingExpectation], timeout: 2.0)
    }

    func testMainPeresenter_GetAlbumErrorCalled() throws {
        let album = Media(wrapperType: .collection, artistName: "foo", collectionName: "bar", collectionId: 1, artistViewURL: "url", collectionViewURL: nil, artworkUrl60: nil, artworkUrl100: nil, trackName: nil, collectionPrice: nil, collectionExplicitness: "foo", trackCount: 1, copyright: nil, country: "FOO", releaseDate: "bar", contentAdvisoryRating: "foo", trackNumber: nil, trackTimeMillis: 1, tracks: nil)

        view = MockView()
        dataServise = MockDetailDataService()
        sut = DetailPresenter(view: view, dataServise: dataServise, router: router, album: album)

        sut.getAlbum(forID: 1)

        wait(for: [view.viewShowErrorExpectation], timeout: 2.0)
    }
}
