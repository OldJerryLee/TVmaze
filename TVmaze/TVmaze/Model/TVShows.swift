//
//  TVShow.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 19/01/23.
//

import Foundation

// MARK: - TVShowElement
struct TVShowElement: Codable {
    let show: Show
}

// MARK: - Show
struct Show: Codable {
    let name: String
    let status: Status
    let rating: Rating
    let image: Image
    let summary: String?
}

// MARK: - Image
struct Image: Codable {
    let medium, original: String
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double?
}

enum Status: String, Codable {
    case ended = "Ended"
    case running = "Running"
    case toBeDetermined = "To Be Determined"
}

typealias TVShows = [TVShowElement]
