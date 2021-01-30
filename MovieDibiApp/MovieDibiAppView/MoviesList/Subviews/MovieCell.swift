//
//  MovieCell.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppViewModel
import MovieDibiAppCommon
import TinyConstraints
import Kingfisher

public class MovieCell: UITableViewCell {

    private lazy var shadowView: ShadowView = {
        let view = ShadowView(shadowColor: .black,
                              shadowOffset: CGSize(width: 3.5,height: 3.5),
                              shadowOpacity: 0.5,
                              shadowRadius: 2.0,
                              cornerRadius: 7.0)
        view.backgroundColor = .white
        return view
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 7.0
        view.backgroundColor = .white
        return view
    }()

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sharedInit()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
    }

    private func sharedInit() {
        createViewsHierarchy()
        setupLayout()
        configureViews()
    }

    private func createViewsHierarchy() {
        contentView.add(
            shadowView.add(
                containerView.add(
                    
                )
            )
        )
    }

    private func setupLayout() {
        shadowView.edgesToSuperview(insets: .init(top: 7.5, left: 7.5, bottom: 7.5, right: 7.5))
        
        containerView.edgesToSuperview()
    }

    private func configureViews() {
        selectionStyle = .none
    }

    public func setupCell(with viewModel: MovieCellViewModel?) {
        guard let viewModel = viewModel else { return }
    }

    public func changeCellBackgroundColorIfNeeded(_ isNeeded: Bool) {
        containerView.backgroundColor = isNeeded ? .offWhite : .white
    }

}
