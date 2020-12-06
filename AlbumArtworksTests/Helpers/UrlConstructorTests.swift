//
//  URLConstructorTests.swift
//  AlbumArtworksTests
//
//  Created by Roman Trekhlebov on 06.12.2020.
//

import XCTest
@testable import AlbumArtworks

class URLConstructorTests: XCTestCase {
    var term: String!
    var limit: Int!
    var offset: Int!

    override func setUp() {
        super.setUp()
        term = "foo"
        limit = 200
        offset = 10
    }
    override func tearDown() {
        term = nil
        limit = nil
        offset = nil
        super.tearDown()
    }

    func testUrlConstructor_getMusic() throws {

        //given
        let expectedUrlString =  "https://itunes.apple.com/search?term=foo&country=RU&media=music" +
            "&entity=album&attribute=albumTerm&explicit=No"
        //when
        let sut = UrlConstructor.getMusicByTermUrl(term: term)
        //then
        XCTAssertEqual(sut?.absoluteString, expectedUrlString)
    }

    func testUrlConstructor_getMusicWithLimit() throws {

        //given
        let expectedUrlString =  "https://itunes.apple.com/search?term=foo&country=RU&media=music" +
            "&entity=album&attribute=albumTerm&explicit=No&limit=200"
        //when
        let sut = UrlConstructor.getMusicByTermUrl(term: term, limit: limit)
        //then
        XCTAssertEqual(sut?.absoluteString, expectedUrlString)
    }
    func testUrlConstructor_getMusicWithLimitAndOffset() throws {

        //given
        let expectedUrlString =  "https://itunes.apple.com/search?term=foo&country=RU&media=music" +
            "&entity=album&attribute=albumTerm&explicit=No&limit=200&offset=10"
        //when
        let sut = UrlConstructor.getMusicByTermUrl(term: term, limit: limit, offset: offset)
        //then
        XCTAssertEqual(sut?.absoluteString, expectedUrlString)
    }
}
