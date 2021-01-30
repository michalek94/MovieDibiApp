//
//  UIButton+TouchArea.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

private var pTouchAreaEdgeInsets: UIEdgeInsets = .zero

extension UIButton {
    var touchAreaEdgeInsets: UIEdgeInsets {
        get {
            if let value = objc_getAssociatedObject(self, &pTouchAreaEdgeInsets) as? NSValue {
                var edgeInsets: UIEdgeInsets = .zero
                value.getValue(&edgeInsets)
                return edgeInsets
            } else {
                return .zero
            }
        }
        set(newValue) {
            var newValueCopy = newValue
            let objCType = NSValue(uiEdgeInsets: .zero).objCType
            let value = NSValue(&newValueCopy, withObjCType: objCType)
            objc_setAssociatedObject(self, &pTouchAreaEdgeInsets, value, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if touchAreaEdgeInsets == .zero || !isEnabled || isHidden {
            return super.point(inside: point, with: event)
        }
        
        let relativeFrame = bounds
        let hitFrame = relativeFrame.inset(by: touchAreaEdgeInsets)
        
        return hitFrame.contains(point)
    }
}
