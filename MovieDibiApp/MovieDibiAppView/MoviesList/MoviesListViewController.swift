//
//  MoviesListViewController.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppViewModel
import MovieDibiAppCommon
import TinyConstraints

public final class MoviesListViewController: BaseViewController<MoviesListViewModel> {

    private var moviesListView: MoviesListView { view as! MoviesListView }
    private var cachedCellHeights = [IndexPath: CGFloat]()

    public override init(viewModel: MoviesListViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) { nil }

    public override func loadView() {
        view = MoviesListView(viewModel: viewModel)
        super.loadView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
    }

    public override func setupSubviews() {
        super.setupSubviews()
        moviesListView.searchBar.delegate = self
        moviesListView.tableView.delegate = self
        moviesListView.tableView.dataSource = self
        moviesListView.tableView.pagingDelegate = self
    }

}

extension MoviesListViewController: MoviesListViewModelDelegate {
    public func onDataLoadingStarted() {
        moviesListView.tableView.showLoadingFooterIfNeeded(true)
    }
    
    public func onDataLoadingFinished() {
        moviesListView.tableView.showLoadingFooterIfNeeded(false)
    }
    
    public func onDataReady() {
        DispatchQueue.main.async { [weak self] in
            self?.moviesListView.tableView.reloadData()
        }
    }
    
    public func onMoreDataToFetchIfNeeded(_ isNeeded: Bool) {
        moviesListView.tableView.showLoadingFooterIfNeeded(isNeeded)
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension MoviesListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cachedCellHeights[indexPath] = cell.frame.height
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = cachedCellHeights[indexPath] {
            return height
        }
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.flowToMovieDetails(atIndexPath: indexPath)
    }
}

extension MoviesListViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int { viewModel.numberOfSections }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel.numberOfRowsInSection }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupCell(with: viewModel.getCellViewModel(atIndexPath: indexPath))
        return cell
    }
}

extension MoviesListViewController: PaginableTableViewDelegate {
    public func loadMoreItems(currentPage: Int) {
        viewModel.loadMoreData(atPage: currentPage)
    }
    
    public func refresh(completion: @escaping () -> ()) {
        viewModel.reloadData(completion: completion)
    }
}
