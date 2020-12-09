//
//  NetworkDataFetcher.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 06.12.2020.
//

import Foundation

protocol DataFetcher {
    func fetchGenericJsonData<T: Decodable>(resource: Resource<T>,
                                            completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkDataFetcher: DataFetcher {

    private let networkService: Networking

    init(networkService: Networking = NetworkService()) {
        self.networkService = networkService
    }

    func fetchGenericJsonData<T>(resource: Resource<T>,
                                 completion: @escaping (Result<T, NetworkError>) -> Void)
    where T: Codable {
        networkService.request(url: resource.url, method: resource.httpMethod) { result in

            do {
                let data = try result.get()
                if let decoded = self.decodeJSON(type: T.self, data: data) {
                    completion(.success(decoded))
                } else {
                    completion(.failure(.decodingError))
                }
            } catch {
                completion(.failure(.domainError))

            }
        }
    }

    private func decodeJSON<T>(type: T.Type, data: Data?) -> T? where  T: Decodable {
        let decoder = JSONDecoder()
        guard let data = data else {return nil}

        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch let jsonError {
            print("Failed to decode Json, \(jsonError)")
            return nil
        }
    }
}
