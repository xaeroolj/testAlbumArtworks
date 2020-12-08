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
    let collectionId: Int
    let artistViewURL: String?
    let collectionViewURL: String?
    let artworkUrl60, artworkUrl100, trackName: String?
    let collectionPrice: Double?
    let collectionExplicitness: String
    let trackCount: Int
    let copyright: String?
    let country: String
    let releaseDate: String
    let contentAdvisoryRating: String?
    let trackNumber: Int?
    let trackTimeMillis: Int?

    var tracks: [Track]?

    enum CodingKeys: String, CodingKey {
        case wrapperType, artistName, collectionName, collectionId
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case artworkUrl60, artworkUrl100, trackName, collectionPrice, collectionExplicitness,
             trackCount, copyright, country, releaseDate, contentAdvisoryRating, trackNumber, trackTimeMillis
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

extension Media: AlbumDetailModelProtocol {

    var albumId: Int {
        return self.collectionId
    }

    mutating func addTracks(from mediaData: [Media]) {
        self.tracks = prepareTracks(from: mediaData)
    }

    private func prepareTracks(from mediaData: [Media]) -> [Track] {
        let tracksMedia = mediaData.filter { media -> Bool in
            return media.wrapperType == .track
        }

        return tracksMedia.compactMap { Track(from: $0)}
    }
}
