//
//  UIDevice+SafeArea.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

extension UIDevice {
    public var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            guard let bottomSafeAreaInset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom, bottomSafeAreaInset > 0 else {
                return false
            }
            return true
        } else {
            return false
        }
    }

    public var topSafeAreaInset: CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        } else {
            return 0
        }
    }

    public var bottomSafeAreaInset: CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }

    public var leftSafeAreaInset: CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.left ?? 0
        } else {
            return 0
        }
    }

    public var rightSafeAreaInset: CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.right ?? 0
        } else {
            return 0
        }
    }
}
