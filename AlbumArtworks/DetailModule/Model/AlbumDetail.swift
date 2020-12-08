//
//  AlbumDetail.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 07.12.2020.
//

import Foundation

protocol AlbumDetailModelProtocol: AlbumMainModelProtocol {
    var albumId: Int {get}
    var collectionPrice: Double? {get}
    var tracks: [Track]? {get set}

    mutating func addTracks(from mediaData: [Media])
}

struct Track {
    let artist: String
    let trackName: String
    let trackNumber: Int
    let trackTimeMillis: Int

    init?(from media: Media) {
        guard media.wrapperType == .track else { return nil}
        artist = media.artistName
        trackName = media.trackName ?? "Not Set"
        trackNumber = media.trackNumber ?? 0
        trackTimeMillis = media.trackTimeMillis ?? 0
    }
}
