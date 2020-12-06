//
//  NetworkErrors.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 06.12.2020.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case notFound
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodingError:
            return NSLocalizedString("decodingError", comment: "")
        case .domainError:
            return NSLocalizedString("domainError", comment: "")
        case .notFound:
            return NSLocalizedString("noFoundError", comment: "")
        }
    }
}
