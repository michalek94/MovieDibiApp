//
//  InitialCoordinator.swift
//  MovieDibiApp
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppService
import MovieDibiAppModel
import MovieDibiAppCommon

public class InitialCoordinator: FlowCoordinator {

    private let window: UIWindow
    private let dependencies: Dependencies
    
    public init(window: UIWindow,
                dependencies: Dependencies) {
        self.window = window
        self.dependencies = dependencies
        super.init()
    }
    
    public override func start() {
        let storyboard = UIStoryboard(name: AppConstants.launchScreenName, bundle: nil)
        let launchScreenViewController = storyboard.instantiateInitialViewController()
        
        window.rootViewController = launchScreenViewController
        window.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.switchToMainCoordinator()
        }
    }
    
    private func switchToMainCoordinator() {
        let coordinator: MainAppCoordinator = MainAppCoordinator(window: window,
                                                                 dependencies: dependencies)
        start(childCoordinator: coordinator)
    }
    
}
