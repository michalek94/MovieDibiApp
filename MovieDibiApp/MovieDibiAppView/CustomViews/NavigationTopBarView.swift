//
//  NavigationTopBarView.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppCommon
import TinyConstraints

public protocol NavigationTopBarViewDelegate: class {
    func leftButtonTapped(inView view: NavigationTopBarView, sender: UIButton)
}

public class NavigationTopBarView: UIView {
    
    public weak var delegate: NavigationTopBarViewDelegate?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var barView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setImage(R.image.backArrowIcon(), for: .normal)
        button.addTarget(self, action: #selector(NavigationTopBarView.leftButtonTapped(_:)), for: .touchUpInside)
        button.touchAreaEdgeInsets = UIEdgeInsets(top: -20.0, left: -20.0, bottom: -20.0, right: -20.0)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    public init() {
        super.init(frame: .zero)
        createViewsHierarchy()
        setupLayout()
        configureViews()
        styleViews()
    }
    
    public required init?(coder: NSCoder) { nil }
    
    private func createViewsHierarchy() {
        add(
            containerView.add(
                barView.add(
                    leftButton,
                    titleLabel
                )
            )
        )
    }
    
    private func setupLayout() {
        containerView.edgesToSuperview()
        
        barView.topToSuperview(offset: UIApplication.shared.statusBarFrame.height)
        barView.edgesToSuperview(excluding: .top)
        barView.height(60.0)
        
        leftButton.leadingToSuperview(offset: 20.0)
        leftButton.centerYToSuperview()
        leftButton.size(CGSize(width: 20.0, height: 20.0))
        
        titleLabel.centerInSuperview()
        titleLabel.height(45.0)
    }
    
    private func configureViews() {
        
    }
    
    private func styleViews() {
        backgroundColor = .white
    }
    
    @objc private func leftButtonTapped(_ sender: UIButton) {
        delegate?.leftButtonTapped(inView: self, sender: sender)
    }
    
    public func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    public func showHideBackButtonIfNeeded(_ isNeeded: Bool = true) {
        isNeeded ? leftButton.fadeIn() : leftButton.fadeOut()
    }
    
}

