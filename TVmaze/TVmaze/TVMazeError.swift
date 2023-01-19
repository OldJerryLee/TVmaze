//
//  TVMazeError.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 19/01/23.
//

import Foundation

enum TVMazeError: String, Error {
    case invalidTitle = "This is username created an invalid request. Please, try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this TV Show. Plese try again."
    case alreadyInFavorites = "You've already favorite this TV Show. You must Really like them!"
}
