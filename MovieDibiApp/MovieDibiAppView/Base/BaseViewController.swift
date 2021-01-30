//
//  BaseViewController.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppViewModel

public class BaseViewController<ViewModel: BaseViewModel>: UIViewController, UIGestureRecognizerDelegate {

    public var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }
    
    public override func loadView() {
        setupSubviews()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        navigationController?.viewControllers.count ?? 0 > 1
    }
    
    public func setupSubviews() { }

}
