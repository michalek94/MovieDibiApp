//
//  UIView+AddSubview.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

extension UIView {
    @discardableResult
    public func add(_ subviews: UIView...) -> UIView {
        return add(subviews)
    }
    
    @discardableResult
    public func add(_ subviews: [UIView]) -> UIView {
        subviews.forEach { [weak self] in
            self?.addSubview($0)
        }
        return self
    }
}
