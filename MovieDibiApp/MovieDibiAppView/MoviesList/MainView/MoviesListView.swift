//
//  MoviesListView.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppViewModel
import MovieDibiAppCommon

public class MoviesListView: BaseView<MoviesListViewModel> {

    private lazy var topBar: NavigationTopBarView = { NavigationTopBarView() }()
    private(set) public lazy var tableView: PaginableTableView = {
        let tableView = PaginableTableView()
        var frame: CGRect = .zero
        frame.size.height = .leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: frame)
        tableView.tableFooterView = UIView(frame: frame)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        tableView.backgroundColor = .white
        tableView.contentInset.bottom = UIDevice.current.bottomSafeAreaInset
        return tableView
    }()

    public override init(viewModel: MoviesListViewModel) {
        super.init(viewModel: viewModel)
        topBar.showHideBackButtonIfNeeded(false)
        viewModel.paginationDataProvider = tableView
    }

    public required init?(coder: NSCoder) { nil }

    public override func createViewsHierarchy() {
        super.createViewsHierarchy()
        add(
            topBar,
            tableView
        )
    }

    public override func setupLayout() {
        super.setupLayout()
        topBar.edgesToSuperview(excluding: .bottom)
        
        tableView.topToBottom(of: topBar)
        tableView.edgesToSuperview(excluding: .top)
    }

    public override func configureViews() {
        super.configureViews()
    }

    public override func styleViews() {
        super.styleViews()
        backgroundColor = .white
    }

}