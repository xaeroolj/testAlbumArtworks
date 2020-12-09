//
//  MockDetailMediaDataserivse.swift
//  AlbumArtworksTests
//
//  Created by Roman Trekhlebov on 09.12.2020.
//

import Foundation
@testable import AlbumArtworks

class MockDetailDataService: MediaServiseProtocolForDetailViewProtocol {

    var response: MediaResponse!

    init() { }
    convenience init(response: MediaResponse?) {
        self.init()
        self.response = response
    }

    func getAlbumTracksFor(albumId: Int, completion: @escaping (Result<MediaResponse, NetworkError>) -> Void) {
        if let response = response {
            completion(.success(response))
        } else {
            completion(.failure(.domainError))
        }
    }
}
