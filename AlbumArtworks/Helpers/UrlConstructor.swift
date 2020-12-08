//
//  UrlConstructor.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 06.12.2020.
//

import Foundation
// MARK: - URLConstructor
final class UrlConstructor {
    static func getMusicByTermUrl(term: String,
                                  limit: Int! = nil,
                                  offset: Int! = nil) -> URL? {
        var components = URLComponents()
        components.scheme = Constants.UrlStrings.scheme
        components.host = Constants.UrlStrings.host
        components.path = "/search"

        components.queryItems = [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "country", value: Constants.UrlStrings.country),
            URLQueryItem(name: "media", value: "music"),
            URLQueryItem(name: "entity", value: "album"),
            URLQueryItem(name: "attribute", value: "albumTerm"),
            URLQueryItem(name: "explicit", value: "No")
        ]

        if let limit = limit {
            components.queryItems!.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        if let offset = offset {
            components.queryItems!.append(URLQueryItem(name: "offset", value: "\(offset)"))
        }
        return components.url
    }
    static func getAlbumDataUrl(albumId: Int) -> URL? {
        var components = URLComponents()
        components.scheme = Constants.UrlStrings.scheme
        components.host = Constants.UrlStrings.host
        components.path = "/lookup"
        components.queryItems = [
            URLQueryItem(name: "id", value: "\(albumId)"),
            URLQueryItem(name: "entity", value: "song")
        ]
        return components.url
    }
}
