//
//  LoaderView.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 01/02/2021.
//

public class LoaderView {

    private var container = UIView()
    private var activityIndicator = UIActivityIndicatorView()

    public func showActivityIndicator(inView view: UIView) {
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = .blackDisabled

        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: container.frame.size.width / 2, y: container.frame.size.height / 2)

        container.addSubview(activityIndicator)
        view.addSubview(container)
        activityIndicator.startAnimating()
    }

    public func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }

}
