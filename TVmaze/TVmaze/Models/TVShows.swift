//
//  TVShow.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 19/01/23.
//

import Foundation

// MARK: - TVShowElement
struct TVShowElement: Codable, Hashable {
    let show: Show

    var hashValue: Int {
        return show.id.hashValue
    }

    static func == (lhs: TVShowElement, rhs: TVShowElement) -> Bool {
        return lhs.show.id == rhs.show.id && lhs.show.id == rhs.show.id
    }
}

// MARK: - Show
struct Show: Codable {
    let id: Int
    let name: String
    let status: Status
    let rating: Rating?
    let image: Image?
    let summary: String?
}

// MARK: - Image
struct Image: Codable {
    let medium: String?
    let original: String?
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double?
}

enum Status: String, Codable {
    case ended = "Ended"
    case running = "Running"
    case toBeDetermined = "To Be Determined"
    case inDevelopment = "In Development"
}

typealias TVShows = [TVShowElement]
