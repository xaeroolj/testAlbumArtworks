//
//  MediaServiseTests.swift
//  AlbumArtworksTests
//
//  Created by Roman Trekhlebov on 09.12.2020.
//

import XCTest
@testable import AlbumArtworks

class MediaServiseTests: XCTestCase {

    var sut: MediaServise!

    override func setUpWithError() throws {
        sut = MediaServise()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    func testMediaServise_getMediaFor() throws {
        //given
        let expectedCollectionId = 1516018680
        let expectation = XCTestExpectation(description: "data recived and checked")
        //when
        sut.getMediaFor(term: "qwea") { (result) in
            do {
                let resultArray = try result.get().mediaArray
                if resultArray.first?.collectionId == expectedCollectionId {
                    expectation.fulfill()
                }
            } catch {return}
        }
        //then
        wait(for: [expectation], timeout: 10.0)
    }

    func testMediaServise_getMediaForf() throws {
        //given
        let expectedArtistName = "$lum"
        let expectation = XCTestExpectation(description: "data recived and checked")
        //when
        sut.getAlbumTracksFor(albumId: 1516018680) { (result) in
            do {
                let resultArray = try result.get().mediaArray
                if resultArray.last?.artistName == expectedArtistName {
                    expectation.fulfill()
                }
            } catch {return}

        }
        //then
        wait(for: [expectation], timeout: 10.0)
    }
}
