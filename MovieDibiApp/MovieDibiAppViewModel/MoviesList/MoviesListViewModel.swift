//
//  MoviesListViewModel.swift
//  MovieDibiAppViewModel
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppService
import MovieDibiAppModel
import MovieDibiAppCommon

public protocol MoviesListViewModelFlowDelegate: class {
    func flowToMovieDetails(with id: Int, title: String)
}

public protocol MoviesListViewModelDelegate: class {
    func onDataLoadingStarted()
    func onDataLoadingFinished()
    func onDataReady()
    func onMoreDataToFetchIfNeeded(_ isNeeded: Bool)
}

public final class MoviesListViewModel: BaseViewModel {

    public weak var flowDelegate: MoviesListViewModelFlowDelegate?
    public weak var delegate: MoviesListViewModelDelegate?
    public weak var paginationDataProvider: PaginationDataProvider?

    private var cellViewModels: [MovieCellViewModel] = []
    private var currentPage: Int { paginationDataProvider?.currentPage ?? 0 }

    public var viewTitle: String {
        R.string.localizable.moviesListViewControllerTopBarTitle()
    }
    public var numberOfSections: Int { 1 }
    public var numberOfRowsInSection: Int { cellViewModels.count }
    public var currentOffset: Int { currentPage * moviesPerPage }
    public var moviesTotalCount: Int = 0
    public var moviesPerPage: Int = 20
    
    public var autoCompletionPossibilities: [String] = []

    private let interactor: MoviesListInteractor

    public init(interactor: MoviesListInteractor) {
        self.interactor = interactor
        super.init()
    }
    
    private func fetchMovies(offset: Int,
                             page: Int,
                             silent: Bool = false,
                             completion: (() -> ())? = nil) {
        if interactor.manager.isInternetReachable {
            notifyLoadingStartedIfNeeded(silent: silent)
            interactor.fetchMoviesList(atPage: page) { [weak self] response in
                self?.notifyLoadingFinishedIfNeeded(silent: silent)
                switch response.result {
                case .success(let response):
                    if !response.results.isEmpty {
                        self?.handleSuccessFetch(movies: response.results,
                                                 totalCount: response.totalResults,
                                                 isReloading: offset == 0)
                    } else {
                        self?.handleEmptyFetch(silent: silent,
                                               completion: completion)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completion?()
            }
        } else {
            print("There is no internet connection!")
        }
    }
    
    public func searchMovie(withQuery query: String, completion: (([String]?) -> ())?) {
        if interactor.manager.isInternetReachable {
            interactor.searchMovie(withQuery: query) { response in
                switch response.result {
                case .success(let response):
                    let titles = response.results.map { $0.title }
                    if !titles.isEmpty {
                        completion?(titles)
                    } else {
                        completion?([])
                    }
                case .failure(let error):
                    completion?([])
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
    
    private func handleSuccessFetch(movies: [Movie], totalCount: Int, isReloading: Bool) {
        moviesTotalCount = totalCount
        
        if isReloading {
            cellViewModels = movies.map { MovieCellViewModel(movie: $0 ) }
        } else {
            cellViewModels.append(contentsOf: movies.map { MovieCellViewModel(movie: $0 )})
        }
        
        delegate?.onDataReady()
        delegate?.onMoreDataToFetchIfNeeded(numberOfRowsInSection < moviesTotalCount)
    }

    private func handleEmptyFetch(silent: Bool, completion: (() -> ())?) {
        cellViewModels = []
        notifyLoadingFinishedIfNeeded(silent: silent)
        completion?()
        delegate?.onDataReady()
    }
    
    public func loadData() {
        fetchMovies(offset: 0, page: 1, silent: false, completion: nil)
    }
    
    public func loadMoreData(atPage page: Int) {
        guard currentOffset < moviesTotalCount else {
            delegate?.onDataLoadingFinished()
            return
        }
        
        fetchMovies(offset: currentOffset, page: page, silent: true, completion: nil)
    }

    public func reloadData(completion: @escaping () -> ()) {
        fetchMovies(offset: 0, page: 1, silent: true, completion: completion)
    }
    
    public func getCellViewModel(atIndexPath indexPath: IndexPath) -> MovieCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    public func flowToMovieDetails(atIndexPath indexPath: IndexPath) {
        flowDelegate?.flowToMovieDetails(with: cellViewModels[indexPath.row].id,
                                         title: cellViewModels[indexPath.row].movieTitle)
    }
    
    public func resetData() {
        cellViewModels = []
        delegate?.onDataReady()
    }
    
}
