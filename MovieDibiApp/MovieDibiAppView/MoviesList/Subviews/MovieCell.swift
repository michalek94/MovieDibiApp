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
    
    private lazy var textContentView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 7.0
        view.backgroundColor = .clear
        return view
    }()

    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var movieOriginalTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .blackDisabled
        return label
    }()

    private lazy var movieVoteDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        label.textColor = .blackDisabled
        return label
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
        posterImageView.kf.cancelDownloadTask()
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
                    posterImageView,
                    textContentView.add(
                        movieTitleLabel,
                        movieOriginalTitleLabel,
                        movieVoteDateLabel
                    )
                )
            )
        )
    }

    private func setupLayout() {
        shadowView.edgesToSuperview(insets: .init(top: 7.5, left: 7.5, bottom: 7.5, right: 7.5))
        
        containerView.edgesToSuperview()
        
        posterImageView.edgesToSuperview(excluding: [.trailing])
        posterImageView.size(CGSize(width: 78.0, height: 117.0))
        
        textContentView.topToSuperview(relation: .equalOrGreater)
        textContentView.leadingToTrailing(of: posterImageView)
        textContentView.centerY(to: posterImageView)
        textContentView.trailingToSuperview()
        textContentView.bottomToSuperview(relation: .equalOrLess)
        
        movieTitleLabel.topToSuperview()
        movieTitleLabel.leadingToSuperview(offset: 7.5)
        movieTitleLabel.trailingToSuperview(offset: 7.5)
        
        movieOriginalTitleLabel.topToBottom(of: movieTitleLabel)
        movieOriginalTitleLabel.leadingToSuperview(offset: 7.5)
        movieOriginalTitleLabel.trailingToSuperview(offset: 7.5)
        
        movieVoteDateLabel.topToBottom(of: movieOriginalTitleLabel, offset: 7.5)
        movieVoteDateLabel.leadingToSuperview(offset: 7.5)
        movieVoteDateLabel.trailingToSuperview(offset: 7.5)
        movieVoteDateLabel.bottomToSuperview()
    }

    private func configureViews() {
        selectionStyle = .none
    }

    public func setupCell(with viewModel: MovieCellViewModel?) {
        guard let viewModel = viewModel else { return }
        posterImageView.kf.setImage(with: viewModel.posterUrl,
                                    placeholder: R.image.photo_placeholder_icon())
        movieTitleLabel.text = viewModel.movieTitle
        movieOriginalTitleLabel.text = viewModel.movieOriginalTitle
        movieVoteDateLabel.text = viewModel.movieVoteDate
    }

}
