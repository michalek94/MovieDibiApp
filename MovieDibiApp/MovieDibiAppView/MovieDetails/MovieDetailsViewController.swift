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

    private var moviesListView: MovieDetailView { view as! MovieDetailView }

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
    }

    public override func setupSubviews() {
        
    }

}

extension MovieDetailsViewController: MovieDetailsViewModelDelegate {
    public func onDataLoadingStarted() {
        
    }
    
    public func onDataLoadingFinished() {
        
    }
    
    public func onDataReady() {
        
    }
}

