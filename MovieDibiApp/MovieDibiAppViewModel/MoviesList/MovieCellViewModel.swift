//
//  MovieCellViewModel.swift
//  MovieDibiAppViewModel
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppModel
import MovieDibiAppCommon

public final class MovieCellViewModel: BaseViewModel {
    
    public var id: Int { movie.id }
    
    private let movie: Movie
    
    public init(movie: Movie) {
        self.movie = movie
        super.init()
    }
    
}
