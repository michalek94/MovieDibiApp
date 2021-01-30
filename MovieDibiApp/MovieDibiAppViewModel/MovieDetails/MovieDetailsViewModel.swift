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
    
    private let interactor: MovieDetailsInteractor
    private let movieId: Int
    
    public init(interactor: MovieDetailsInteractor,
                movieId: Int) {
        self.interactor = interactor
        self.movieId = movieId
        super.init()
    }
    
    private func fetchMovieDetails() {
        if interactor.manager.isInternetReachable {
            
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

    private func handleSuccess() {

        delegate?.onDataReady()
    }

    private func handleEmptyFetch() {
        
    }

    public func loadData() {
        
    }
    
}
