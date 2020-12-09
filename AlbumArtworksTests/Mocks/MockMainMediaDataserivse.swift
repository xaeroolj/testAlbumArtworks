//
//  MockMediaDataserivse.swift
//  AlbumArtworksTests
//
//  Created by Roman Trekhlebov on 09.12.2020.
//

import XCTest
@testable import AlbumArtworks

class MockMainDataService: MediaServiseProtocolForMainViewProtocol {
    var response: MediaResponse!

    init() { }
    convenience init(response: MediaResponse?) {
        self.init()
        self.response = response
    }

    func getMediaFor(term: String, completion: @escaping (Result<MediaResponse, NetworkError>) -> Void) {
        if let response = response {
            completion(.success(response))
        } else {
            completion(.failure(.domainError))
        }
    }
}
