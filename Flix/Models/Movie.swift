//
//  Movie.swift
//  Flix
//
//  Created by Danny on 10/4/18.
//  Copyright © 2018 Danny Rivera. All rights reserved.
//

import Foundation
class Movie {
    
    var title: String
    var overview: String
    var releaseDate: String
    var posterPathString: String
    var backDropPathString: String
    var posterUrl: URL?
    var backDropUrl: URL?
    
    let baseURLString = "https://image.tmdb.org/t/p/w500"
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? "No Title"
        self.overview = dictionary["overview"] as? String ?? "No Overview"
        self.releaseDate = dictionary["release_date"] as? String ?? "No Release Date"
        self.posterPathString = dictionary["poster_path"] as? String ?? "No Poster Path"
        self.backDropPathString = dictionary["backdrop_path"] as? String ?? "No Back Drop Path"
        self.posterUrl = URL(string: baseURLString + posterPathString)
        self.backDropUrl = URL(string: baseURLString + backDropPathString)
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        return movies
    }
}
