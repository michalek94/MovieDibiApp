//
//  MovieDetailsViewController.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppViewModel
import MovieDibiAppCommon
import TinyConstraints

public final class MovieDetailsViewController: BaseViewController<MovieDetailsViewModel> {

    private var movieDetailsView: MovieDetailView { view as! MovieDetailView }
    private let loaderView = LoaderView()

    public override init(viewModel: MovieDetailsViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) { nil }

    public override func loadView() {
        view = MovieDetailView(viewModel: viewModel)
        super.loadView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMovieDetails()
    }

    public override func setupSubviews() {
        super.setupSubviews()
        movieDetailsView.topBar.delegate = self
    }

}

extension MovieDetailsViewController: NavigationTopBarViewDelegate {
    public func leftButtonTapped(inView view: NavigationTopBarView, sender: UIButton) {
        viewModel.onFlowBackRequested()
    }
    
    public func rightButtonTapped(inView view: NavigationTopBarView, sender: UIButton) {
        if viewModel.movieIsFavorite {
            viewModel.movieIsFavorite = false
            view.updateRightButton(false)
        } else {
            viewModel.movieIsFavorite = true
            view.updateRightButton(true)
        }
    }
}

extension MovieDetailsViewController: MovieDetailsViewModelDelegate {
    public func onDataLoadingStarted() {
        loaderView.showActivityIndicator(inView: view)
    }
    
    public func onDataLoadingFinished() {
        loaderView.hideActivityIndicator()
    }
    
    public func onDataReady() {
        movieDetailsView.updateSubviews(with: viewModel)
    }
}
