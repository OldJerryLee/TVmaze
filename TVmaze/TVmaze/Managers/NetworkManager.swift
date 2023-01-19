//
//  NetworkManager.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 19/01/23.
//

import UIKit

//->shows/525/akas
class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.tvmaze.com/"
    let cache = NSCache<NSString,UIImage>()

    private init() {}

    func getTVShows(for title: String, completed: @escaping (Result<TVShows, TVMazeError>) -> Void) {
        let endpoint = baseURL + "search/shows?q=\(title)"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidTitle))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let tvShows = try decoder.decode(TVShows.self, from: data)
                completed(.success(tvShows))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }

    func getAkas(for id: Int, completed: @escaping (Result<Akas, TVMazeError>) -> Void) {
        let endpoint = baseURL + "shows/\(id)/akas"

        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidTitle))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let akas = try decoder.decode(Akas.self, from: data)
                completed(.success(akas))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
