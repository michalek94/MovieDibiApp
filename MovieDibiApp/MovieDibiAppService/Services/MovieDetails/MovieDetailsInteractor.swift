//
//  MovieDetailsInteractor.swift
//  MovieDibiAppService
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppModel
import Alamofire

public protocol MovieDetailsInteracting {
    func fetchMovieDetails(withId id: Int,
                           completionHandler: ((DataResponse<MovieDetails, AFError>) -> ())?)
}

public class MovieDetailsInteractor: ConnectionService, MovieDetailsInteracting {
    public func fetchMovieDetails(withId id: Int,
                                  completionHandler: ((DataResponse<MovieDetails, AFError>) -> ())?) {
        let urlComponents = URLComponents(string: "\(manager.baseUrl)movie/\(id)")!
        manager.request(urlComponents, completionHandler: completionHandler)
    }
}
