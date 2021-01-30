//
//  UITablewView+CellIdentifiable.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

protocol CellIdentifiable {
    static var identifier: String { get }
}

extension CellIdentifiable where Self: UITableViewCell {
    static var identifier: String { String(describing: self) }
}

extension UITableViewCell: CellIdentifiable { }

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Error occurred while dequeuing cell for identifier \(T.identifier)")
        }
        return cell
    }
}
