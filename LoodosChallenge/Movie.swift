//
//  Movie.swift
//  LoodosChallenge
//
//  Created by Sociable on 3.06.2021.
//

import Foundation

struct MovieResponse: Codable {
    let Title: String
    let Year: String
    let Rated: String
    let Released: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Writer: String
    let Plot: String
    let Language: String
    let Country: String
    let Poster: String
    let imdbID: String
    let imdbRating: String
    let Response: String
}
