//
//  NetworkService.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 06.12.2020.
//

import UIKit

protocol Networking {
    func request(url: URL, method: HttpMethod, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

final class NetworkService: Networking {

    var task: URLSessionDataTask?

    func request(url: URL, method: HttpMethod, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        self.task?.cancel()
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let task = createDataTask(from: request, completion: completion)
        self.task = task

        self.isLoading(true)
        self.task?.resume()

    }

    private func isLoading(_ status: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = status
        }
    }

    private func createDataTask(from request: URLRequest,
                                completion: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            defer {
                self?.task = nil
                self?.isLoading(false)
            }
            guard let response = response as? HTTPURLResponse,
                  let data = data else {
                completion(.failure(NetworkError.domainError))
                return}
            let status = response.statusCode
            if status == 404 {
                completion(.failure(NetworkError.notFound))
                return
            }

            if let error = error as NSError? {
                if error.code == NSURLErrorCancelled {
                    return
                }
            }
            completion(.success(data))
        }
    }
}
