//
//  MovieCellViewModel.swift
//  MovieDibiAppViewModel
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppModel
import MovieDibiAppCommon

public final class MovieCellViewModel: BaseViewModel {

    private let userDefaults = UserDefaults.standard
    
    public var id: Int { movie.id }
    public var posterUrl: URL { movie.posterUrl }
    public var movieTitle: String { movie.title }
    public var movieOriginalTitle: String { movie.originalTitle }
    public var movieVoteDate: String? {
        if let date = movie.releaseDateFormatted {
            return String(format: "%@ - %@", movie.voteAverageText, date)
        } else {
            return String(format: "%@", movie.voteAverageText)
        }
    }
    public var movieIsFavorite: Bool {
        get {
            let favoriteMovies = userDefaults.array(forKey: AppConstants.favoritesMoviesIdsKey) as? [Int]
            return favoriteMovies?.contains(self.id) ?? false
        }
        set {
            var favoriteMovies = userDefaults.array(forKey: AppConstants.favoritesMoviesIdsKey) as? [Int]
            if newValue {
                if let _ = favoriteMovies {
                    favoriteMovies?.append(self.id)
                } else {
                    favoriteMovies = []
                    favoriteMovies?.append(self.id)
                }
            } else {
                favoriteMovies?.removeAll(where: { $0 == self.id })
            }
            UserDefaults.standard.set(favoriteMovies, forKey: AppConstants.favoritesMoviesIdsKey)
        }
    }

    private let movie: Movie

    public init(movie: Movie) {
        self.movie = movie
        super.init()
    }

}
