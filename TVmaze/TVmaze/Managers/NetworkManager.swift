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

    func downloadImage(from urlString: String, completed: @escaping (UIImage?)-> Void) {
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                    completed(nil)
                    return
                  }

            self.cache.setObject(image, forKey: cacheKey)

            DispatchQueue.main.async {
                completed(image)
            }
        }
        task.resume()
    }
}
