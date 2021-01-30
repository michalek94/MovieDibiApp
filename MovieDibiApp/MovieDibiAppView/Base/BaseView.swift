//
//  BaseView.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppViewModel

public class BaseView<ViewModel: BaseViewModel>: UIView {

    public var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        createViewsHierarchy()
        setupLayout()
        configureViews()
        styleViews()
    }

    public required init?(coder: NSCoder) { nil }

    public func createViewsHierarchy() {}

    public func setupLayout() {}

    public func configureViews() {}

    public func styleViews() {}

}
