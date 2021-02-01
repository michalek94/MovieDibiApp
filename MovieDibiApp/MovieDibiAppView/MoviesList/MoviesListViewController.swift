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
    private var isReplacing: Bool = false

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

        NotificationCenter.default.addObserver(self, selector: #selector(MoviesListViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MoviesListViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesListView.tableView.reloadData()
    }

    public override func setupSubviews() {
        super.setupSubviews()
        moviesListView.searchTextField.delegate = self
        moviesListView.searchTextField.addTarget(self, action: #selector(MoviesListViewController.searchTextFieldDidChange(_:)), for: .editingChanged)
        moviesListView.tableView.delegate = self
        moviesListView.tableView.dataSource = self
        moviesListView.tableView.pagingDelegate = self
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo!
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let options = UIView.AnimationOptions(rawValue: curve)
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        let bottomSafeAreaHeight = UIDevice.current.bottomSafeAreaInset
        let contentInset: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.size.height - bottomSafeAreaHeight - 60.0, right: 0.0)

        UIView.animate(withDuration: duration, delay: 0, options: options) { [weak self] in
            self?.view.layoutIfNeeded()
            self?.moviesListView.tableView.contentInset = contentInset
            self?.moviesListView.tableView.scrollIndicatorInsets = contentInset
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: AppConstants.appDefaultAnimationDuration) { [weak self] in
            self?.view.layoutIfNeeded()
            self?.moviesListView.tableView.contentInset = .zero
            self?.moviesListView.tableView.scrollIndicatorInsets = .zero
        }
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

extension MoviesListViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let char = string.cString(using: String.Encoding.utf8)
        let isBackSpace: Int = Int(strcmp(char, "\u{8}"))
        
        if isBackSpace == -8, let textRange = textField.selectedTextRange {
            isReplacing = true
            textField.replace(textRange, withText: "")
        } else {
            isReplacing = false
        }
        
        return true
    }
    
    @objc private func searchTextFieldDidChange(_ sender: UITextField) {
        let textToSearch = sender.text ?? ""
        if (textToSearch.count > 1), !isReplacing {
            viewModel.searchQuery = textToSearch
            viewModel.loadSearchData { [weak self] (titles) in
                self?.autoCompleteText(in: sender, using: textToSearch, suggestionsArray: titles ?? [])
            }
        }
        if textToSearch.isEmpty {
            viewModel.loadData()
        }
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        isReplacing = false
        textField.resignFirstResponder()
        viewModel.loadSearchData()
        return true
    }

    private func autoCompleteText(in textField: UITextField, using string: String, suggestionsArray: [String]) {
        if !string.isEmpty, let selectedTextRange = textField.selectedTextRange, selectedTextRange.end == textField.endOfDocument,
           let prefixRange = textField.textRange(from: textField.beginningOfDocument, to: selectedTextRange.start),
           let text = textField.text(in: prefixRange) {
            let matches = suggestionsArray.filter { $0.lowercased().hasPrefix(text.lowercased()) }
            if (matches.count > 0) {
                textField.text = matches[0]
                if let start = textField.position(from: textField.beginningOfDocument, offset: text.count) {
                    textField.selectedTextRange = textField.textRange(from: start, to: textField.endOfDocument)
                }
            }
        }
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
        viewModel.loadMoreSearchData(atPage: currentPage)
    }

    public func refresh(completion: @escaping () -> ()) {
        viewModel.reloadData(completion: completion)
        viewModel.reloadSearchData(refreshCompletion: completion)
    }
}
