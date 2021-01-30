//
//  MainCoordinator.swift
//  MovieDibiApp
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppService
import MovieDibiAppModel
import MovieDibiAppCommon

public class MainAppCoordinator: NavigationFlowCoordinator {

    private let window: UIWindow
    private let dependencies: Dependencies
 
    public init(window: UIWindow,
                dependencies: Dependencies) {
        self.window = window
        self.dependencies = dependencies
        super.init()
    }

    public override func start() {
        super.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        switchToMoviesCoordinator()
    }

    private func switchToMoviesCoordinator() {
        let coordinator: MoviesCoordinator = MoviesCoordinator(window: window,
                                                               dependencies: dependencies)
        start(childCoordinator: coordinator)
    }

}
