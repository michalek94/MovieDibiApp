//
//  MovieDetailsInteractor.swift
//  MovieDibiAppService
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppModel
import Alamofire

public protocol MovieDetailsInteracting {
    func fetchMovieDetails()
}

public class MovieDetailsInteractor: ConnectionService, MovieDetailsInteracting {
    public func fetchMovieDetails() {
        
    }
}
