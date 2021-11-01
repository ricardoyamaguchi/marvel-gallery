//
//  Connection.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 16/10/21.
//

import Foundation

typealias Completion<T: Codable> = ((Result<T>) -> Void)
typealias DataCompletion = ((ResultData) -> Void)

enum ResultData {
    case success(Data)
    case failure(Error?)
}

enum Result<T: Codable> {
    case success([T]?)
    case failure(Error?)
}

struct Connection {

    private let scheme = "https"
    private let host = "gateway.marvel.com"
    private let version = "/v1"
    private let domain = "/public"

    private let kTs = "0"
    private let kApiKey = "0e3b7a907ce8ed9f13a5264d066221c6"
    private let kHash = "656a105a0efa67531f20de59d5f06e39"

    func request<T: Codable>(method: HttpMethod,
                             endpoint: String,
                             params: [URLQueryItem]?,
                             completion: @escaping Completion<T>) {

        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "\(version)\(domain)\(endpoint)"
        urlComponents.queryItems = [
            URLQueryItem(name: "ts", value: kTs),
            URLQueryItem(name: "apikey", value: kApiKey),
            URLQueryItem(name: "hash", value: kHash)
        ]

        if let params = params {
            urlComponents.queryItems?.append(contentsOf: params)
        }

        guard
            let url = urlComponents.url else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in

            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                DispatchQueue.main.async {
                    do {
                        let response = try JSONDecoder().decode(Response<T>.self, from: data)
                        completion(.success(response.data?.results))
                    } catch {
                        completion(.failure(error))
                    }
                }
            } else {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    func request(urlString: String, completion: @escaping DataCompletion) {

        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        task.resume()

    }

}

enum HttpMethod: String {

    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"

}
