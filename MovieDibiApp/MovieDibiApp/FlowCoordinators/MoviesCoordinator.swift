//
//  MoviesCoordinator.swift
//  MovieDibiApp
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppView
import MovieDibiAppViewModel
import MovieDibiAppService
import MovieDibiAppModel
import MovieDibiAppCommon

public class MoviesCoordinator: NavigationFlowCoordinator {

    private let window: UIWindow
    private let dependencies: Dependencies
 
    public init(window: UIWindow,
                dependencies: Dependencies) {
        self.window = window
        self.dependencies = dependencies
        super.init()
    }
    
    public override func createMainViewController() -> UIViewController? {
        let interactor = MoviesListInteractor(manager: dependencies.connectionManager)
        let viewModel = MoviesListViewModel(interactor: interactor)
        viewModel.flowDelegate = self
        let viewController = MoviesListViewController(viewModel: viewModel)
        return viewController
    }

}

extension MoviesCoordinator: MoviesListViewModelFlowDelegate {
    public func flowToMovieDetails(with id: Int) {
        let interactor = MovieDetailsInteractor(manager: dependencies.connectionManager)
        let viewModel = MovieDetailsViewModel(interactor: interactor,
                                              movieId: id)
        viewModel.flowDelegate = self
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        push(viewController: viewController)
    }
}

extension MoviesCoordinator: MovieDetailsViewModelFlowDelegate {
    public func flowBackRequested() {
        popLastViewController()
    }
}
