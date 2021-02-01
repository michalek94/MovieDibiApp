//
//  MovieDetailView.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppViewModel
import MovieDibiAppCommon
import TinyConstraints
import Kingfisher

public class MovieDetailView: BaseView<MovieDetailsViewModel> {
    
    private(set) public lazy var topBar: NavigationTopBarView = { NavigationTopBarView() }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        scrollView.contentInset.bottom = UIDevice.current.bottomSafeAreaInset
        return scrollView
    }()
    private lazy var contentView: UIView = { UIView() }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    public override init(viewModel: MovieDetailsViewModel) {
        super.init(viewModel: viewModel)
        topBar.showHideLeftButtonIfNeeded()
        topBar.showHideRightButtonIfNeeded()
        topBar.topBarTitleText = viewModel.movieTitle
        topBar.updateRightButton(viewModel.movieIsFavorite)
    }
    
    public required init?(coder: NSCoder) { nil }
    
    public override func createViewsHierarchy() {
        super.createViewsHierarchy()
        add(
            topBar,
            scrollView.add(
                contentView.add(
                    posterImageView,
                    movieTitleLabel,
                    movieOriginalTitleLabel,
                    movieVoteDateLabel,
                    movieOverviewLabel
                )
            )
        )
    }
    
    public override func setupLayout() {
        super.setupLayout()
        topBar.edgesToSuperview(excluding: .bottom)
        
        scrollView.topToBottom(of: topBar)
        scrollView.edgesToSuperview(excluding: .top, insets: .init(top: 60.0, left: 0.0, bottom: 0.0, right: 0.0))
        
        contentView.edgesToSuperview(excluding: .bottom)
        contentView.bottomToSuperview(priority: .init(250.0))
        contentView.widthToSuperview()
        contentView.centerXToSuperview()
        contentView.centerYToSuperview(priority: .init(250.0))
        
        posterImageView.edgesToSuperview(excluding: .bottom)
        posterImageView.aspectRatio(1)
        
        movieTitleLabel.topToBottom(of: posterImageView, offset: 15.0)
        movieTitleLabel.horizontalToSuperview(insets: .init(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0))
        
        movieOriginalTitleLabel.topToBottom(of: movieTitleLabel, offset: 3.75)
        movieOriginalTitleLabel.horizontalToSuperview(insets: .init(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0))
        
        movieVoteDateLabel.topToBottom(of: movieOriginalTitleLabel, offset: 15.0)
        movieVoteDateLabel.horizontalToSuperview(insets: .init(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0))
        
        movieOverviewLabel.topToBottom(of: movieVoteDateLabel, offset: 15.0)
        movieOverviewLabel.edgesToSuperview(excluding: [.top, .bottom], insets: .init(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0))
        movieOverviewLabel.bottomToSuperview(offset: -15.0, relation: .equalOrLess)
    }
    
    public override func configureViews() {
        super.configureViews()
    }
    
    public override func styleViews() {
        super.styleViews()
        backgroundColor = .white
    }
    
    public func updateSubviews(with viewModel: MovieDetailsViewModel) {
        posterImageView.kf.setImage(with: viewModel.backdropUrl, placeholder: R.image.photo_placeholder_icon())
        movieTitleLabel.text = viewModel.movieTitle
        movieOriginalTitleLabel.text = viewModel.movieOriginalTitle
        movieVoteDateLabel.text = viewModel.movieVoteDate
        movieOverviewLabel.text = viewModel.movieOverview
    }
    
}
