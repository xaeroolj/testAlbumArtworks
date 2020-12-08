//
//  Album.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 06.12.2020.
//

import Foundation

protocol AlbumMainModelProtocol {
    var albumName: String {get}
    var artworkUrl: String? {get}
    var collectionId: Int {get}
}
