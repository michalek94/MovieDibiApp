//
//  MoviesListView.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppViewModel
import MovieDibiAppCommon
import SearchTextField

public class MoviesListView: BaseView<MoviesListViewModel> {

    private lazy var topBar: NavigationTopBarView = { NavigationTopBarView() }()

    private(set) public lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.enablesReturnKeyAutomatically = true
        textField.keyboardType = .asciiCapable
        textField.placeholder = "Find your favorite movie"
        textField.returnKeyType = .search
        return textField
    }()

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
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()

    public override init(viewModel: MoviesListViewModel) {
        super.init(viewModel: viewModel)
        topBar.topBarTitleText = viewModel.viewTitle
        topBar.showHideLeftButtonIfNeeded(false)
        viewModel.paginationDataProvider = tableView
    }

    public required init?(coder: NSCoder) { nil }

    public override func createViewsHierarchy() {
        super.createViewsHierarchy()
        add(
            topBar,
            searchTextField,
            tableView
        )
    }

    public override func setupLayout() {
        super.setupLayout()
        topBar.edgesToSuperview(excluding: .bottom)
        
        searchTextField.topToBottom(of: topBar)
        searchTextField.leadingToSuperview(offset: 7.5)
        searchTextField.trailingToSuperview(offset: 7.5)
        searchTextField.height(56.0)
        
        tableView.topToBottom(of: searchTextField)
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
