//
//  MoviesListInteractor.swift
//  MovieDibiAppService
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppModel
import Alamofire

public protocol MoviesListInteracting {
    func fetchMoviesList(withLanguage language: String,
                         atPage page: Int,
                         inRegion region: String,
                         completionHandler: ((DataResponse<MoviesResponse, AFError>) -> ())?)
}

public class MoviesListInteractor: ConnectionService, MoviesListInteracting {
    public func fetchMoviesList(withLanguage language: String,
                                atPage page: Int,
                                inRegion region: String,
                                completionHandler: ((DataResponse<MoviesResponse, AFError>) -> ())?) {
        var urlComponents = URLComponents(string: "\(manager.baseUrl)now_playing")!
        let parameters: [String: String] = [
                                            "page": "\(page)"
                                            ]
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        manager.request(urlComponents, completionHandler: completionHandler)
    }
}
