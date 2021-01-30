//
//  PaginableTableView.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppViewModel

public protocol PaginableTableViewDelegate: class {
    func loadMoreItems(currentPage: Int)
    func refresh(completion: @escaping () -> ())
}

public class PaginableTableView: UITableView, PaginationDataProvider {

    private var loadingView = UIView()
    private var activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    private var refreshLoader = UIRefreshControl()

    private let loadingViewHeight: CGFloat = 80

    public var previousItemCount: Int = 0
    public var page: Int = 0

    public var currentPage: Int { page }

    public weak var pagingDelegate: PaginableTableViewDelegate?

    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        createViewsHierarchy()
        setupLayout()
        configureViews()
        styleViews()
    }

    required init?(coder aDecoder: NSCoder) { nil }

    public override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.startAnimating()
    }

    private func createViewsHierarchy() {
        loadingView.add(
            activityIndicatorView
        )
    }

    private func setupLayout() {
        loadingView.frame = CGRect(x: .zero, y: .zero, width: frame.width, height: loadingViewHeight)
        
        activityIndicatorView.centerInSuperview()
    }

    private func configureViews() {
        refreshLoader.addTarget(self, action: #selector(PaginableTableView.refresh(_:)), for: .valueChanged)
        refreshControl = refreshLoader
        refreshControl?.layer.zPosition = -1
    }

    private func styleViews() {
        activityIndicatorView.color = .lightGray
        activityIndicatorView.tintColor = .lightGray
        refreshLoader.tintColor = .lightGray
    }

    private func reset(completion: @escaping () -> ()) {
        resetPagingData()
        pagingDelegate?.refresh(completion: completion)
    }

    private func paginate(tableView: PaginableTableView, forIndexAt indexPath: IndexPath) {
        guard let itemCount = tableView.dataSource?.tableView(tableView, numberOfRowsInSection: indexPath.section) else { return }
        guard indexPath.row == itemCount - 1 else { return }
        guard previousItemCount != itemCount else { return }
        page += 1
        previousItemCount = itemCount
        pagingDelegate?.loadMoreItems(currentPage: page)
    }

    @objc private func refresh(_ sender: UIRefreshControl) {
        reset() { [weak self] in
            self?.refreshControl?.endRefreshing()
        }
    }

    override open func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        paginate(tableView: self, forIndexAt: indexPath)
        return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }

    public func resetPagingData() {
        page = 0
        previousItemCount = 0
    }

    public func showLoadingFooterIfNeeded(_ isNeeded: Bool) {
        isNeeded ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        tableFooterView = isNeeded ? loadingView : nil
    }

}
