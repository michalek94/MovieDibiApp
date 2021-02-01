//
//  MoviesListInteractor.swift
//  MovieDibiAppService
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppModel
import Alamofire

public protocol MoviesListInteracting {
    func fetchMoviesList(atPage page: Int,
                         completionHandler: ((DataResponse<MoviesResponse, AFError>) -> ())?)
    func searchMovie(withQuery query: String,
                     completionHandler: ((DataResponse<MoviesResponse, AFError>) -> ())?)}

public class MoviesListInteractor: ConnectionService, MoviesListInteracting {
    public func fetchMoviesList(atPage page: Int,
                                completionHandler: ((DataResponse<MoviesResponse, AFError>) -> ())?) {
        var urlComponents = URLComponents(string: "\(manager.baseUrl)movie/now_playing")!
        let parameters: [String: String] = ["page": "\(page)"]
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        manager.request(urlComponents, completionHandler: completionHandler)
    }
    
    public func searchMovie(withQuery query: String,
                            completionHandler: ((DataResponse<MoviesResponse, AFError>) -> ())?) {
        var urlComponents = URLComponents(string: "\(manager.baseUrl)search/movie")!
        let parameters: [String: String] = ["query": query]
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        manager.request(urlComponents, completionHandler: completionHandler)
    }
}
