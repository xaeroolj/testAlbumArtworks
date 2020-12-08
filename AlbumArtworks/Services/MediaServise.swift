//
//  MediaServise.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 06.12.2020.
//

import Foundation

typealias MediaServiseProtocol = MediaServiseProtocolForMainViewProtocol & MediaServiseProtocolForDetailViewProtocol

protocol MediaServiseProtocolForMainViewProtocol {
    func getMediaFor(term: String,
                     completion: @escaping (Result<MediaResponse, NetworkError>) -> Void)
}

protocol MediaServiseProtocolForDetailViewProtocol {
    func getAlbumTracksFor(albumId: Int,
                           completion: @escaping (Result<MediaResponse, NetworkError>) -> Void)
}
    final class MediaServise: MediaServiseProtocol {

        private let dataFetcher = NetworkDataFetcher()

        // MARK: - getMediaFor
        func getMediaFor(term: String,
                         completion: @escaping (Result<MediaResponse, NetworkError>) -> Void) {
            if term.isEmpty { return }

            guard let url = UrlConstructor.getMusicByTermUrl(term: term) else {
                print("error on getMediaFor badUrl")
                return
            }

            var resource = Resource<MediaResponse>(url: url)
            resource.httpMethod = .get

            dataFetcher.fetchGenericJsonData(resource: resource) { (result) in
                completion(result)
            }
        }

        // MARK: - getAlbumTracksFor
        func getAlbumTracksFor(albumId: Int,
                               completion: @escaping (Result<MediaResponse, NetworkError>) -> Void) {
            if albumId == 0 { return }

            guard let url = UrlConstructor.getAlbumDataUrl(albumId: albumId) else {
                print("error on getAlbumTracksFor badUrl")
                return
            }

            var resource = Resource<MediaResponse>(url: url)
            resource.httpMethod = .get

            dataFetcher.fetchGenericJsonData(resource: resource) { (result) in
                completion(result)
            }

        }
}
