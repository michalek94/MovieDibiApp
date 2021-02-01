//
//  MovieDetailsViewModel.swift
//  MovieDibiAppViewModel
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppService
import MovieDibiAppModel
import MovieDibiAppCommon

public protocol MovieDetailsViewModelFlowDelegate: class {
    func flowBackRequested()
}

public protocol MovieDetailsViewModelDelegate: class {
    func onDataLoadingStarted()
    func onDataLoadingFinished()
    func onDataReady()
}

public final class MovieDetailsViewModel: BaseViewModel {

    public weak var flowDelegate: MovieDetailsViewModelFlowDelegate?
    public weak var delegate: MovieDetailsViewModelDelegate?
    
    private let userDefaults = UserDefaults.standard
    private var movieDetails: MovieDetails?
    
    public var movieIsFavorite: Bool {
        get {
            let favoriteMovies = userDefaults.array(forKey: AppConstants.favoritesMoviesIdsKey) as? [Int]
            return favoriteMovies?.contains(self.movieId) ?? false
        }
        set {
            var favoriteMovies = userDefaults.array(forKey: AppConstants.favoritesMoviesIdsKey) as? [Int]
            if newValue {
                if let _ = favoriteMovies {
                    favoriteMovies?.append(self.movieId)
                } else {
                    favoriteMovies = []
                    favoriteMovies?.append(self.movieId)
                }
            } else {
                favoriteMovies?.removeAll(where: { $0 == self.movieId })
            }
            UserDefaults.standard.set(favoriteMovies, forKey: AppConstants.favoritesMoviesIdsKey)
        }
    }
    
    public var posterUrl: URL? { movieDetails?.posterUrl }
    public var backdropUrl: URL? { movieDetails?.backdropUrl }
    public var movieOriginalTitle: String? { movieDetails?.originalTitle }
    public var movieVoteDate: String? {
        if let date = movieDetails?.releaseDateFormatted {
            return String(format: "%@ - %@", movieDetails?.voteAverageText ?? "", date)
        } else {
            return String(format: "%@", movieDetails?.voteAverageText ?? "")
        }
    }
    public var movieOverview: String? { movieDetails?.overview }
    
    private let interactor: MovieDetailsInteractor
    private let movieId: Int
    public let movieTitle: String
    
    public init(interactor: MovieDetailsInteractor,
                movieId: Int,
                movieTitle: String) {
        self.interactor = interactor
        self.movieId = movieId
        self.movieTitle = movieTitle
        super.init()
    }
    
    public func fetchMovieDetails() {
        if interactor.manager.isInternetReachable {
            notifyLoadingStartedIfNeeded(silent: false)
            interactor.fetchMovieDetails(withId: movieId) { [weak self] response in
                self?.notifyLoadingFinishedIfNeeded(silent: false)
                switch response.result {
                case .success(let details):
                    self?.movieDetails = details
                    self?.delegate?.onDataReady()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            print("There is no internet connection!")
        }
    }

    private func notifyLoadingStartedIfNeeded(silent: Bool) {
        if !silent { delegate?.onDataLoadingStarted() }
    }

    private func notifyLoadingFinishedIfNeeded(silent: Bool) {
        if !silent { delegate?.onDataLoadingFinished() }
    }
    
    public func onFlowBackRequested() {
        flowDelegate?.flowBackRequested()
    }
    
}
