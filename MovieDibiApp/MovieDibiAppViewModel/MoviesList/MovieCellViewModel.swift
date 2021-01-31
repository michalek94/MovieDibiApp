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
    public var posterUrl: URL { movie.posterUrl }
    public var movieTitle: String? { movie.title }
    public var movieOriginalTitle: String? { movie.originalTitle }
    public var movieVoteDate: String? {
        if let date = movie.releaseDateFormatted {
            return String(format: "%@ - %@", movie.voteAveragePercentText, date)
        } else {
            return String(format: "%@", movie.voteAveragePercentText)
        }
    }

    private let movie: Movie

    public init(movie: Movie) {
        self.movie = movie
        super.init()
    }

}
