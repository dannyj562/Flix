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
    var posterPathString: String
    var backDropPathString: String
    var posterUrl: URL?
    var backDropUrl: URL?
    
    static let apiMovieUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let baseURLString = "https://image.tmdb.org/t/p/w500"
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? "No Title"
        self.overview = dictionary["overview"] as? String ?? "No Overview"
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
