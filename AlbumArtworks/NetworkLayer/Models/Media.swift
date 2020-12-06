//
//  Media.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 06.12.2020.
//

import Foundation

// MARK: - MediaResponse
struct MediaResponse: Codable {
    let resultCount: Int
    let mediaArray: [Media]

    enum CodingKeys: String, CodingKey {
        case resultCount
        case mediaArray = "results"
    }
}

// MARK: - Media
struct Media: Codable {
    let wrapperType: WrapperType
    let artistName, collectionName: String
    let artistViewURL: String?
    let collectionViewURL: String?
    let artworkUrl60, artworkUrl100: String?
    let collectionPrice: Int?
    let collectionExplicitness: String
    let trackCount: Int
    let copyright: String
    let country: String
    let releaseDate: Date
    let contentAdvisoryRating: String?

    enum CodingKeys: String, CodingKey {
        case artistName, collectionName, wrapperType
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case artworkUrl60, artworkUrl100, collectionPrice, collectionExplicitness,
             trackCount, copyright, country, releaseDate, contentAdvisoryRating
    }

    enum WrapperType: String, Codable {
        case collection
        case track
    }
}

extension Media: AlbumMainModelProtocol {
    var albumName: String {
        return self.collectionName
    }
    var artworkUrl: String? {
        if let lowUrl = self.artworkUrl60 {
            return lowUrl
        } else if let hightUrl = self.artworkUrl100 {
            return hightUrl
        }
        return nil
    }
}
