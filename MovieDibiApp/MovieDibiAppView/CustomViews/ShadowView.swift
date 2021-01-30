//
//  ShadowView.swift
//  MovieDibiAppView
//
//  Created by Michał Pankowski on 30/01/2021.
//

public class ShadowView: UIView {

    private let _shadowColor: UIColor
    private let _shadowOffset: CGSize
    private let _shadowOpacity: Float
    private let _shadowRadius: CGFloat
    private let _cornerRadius: CGFloat

    public override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }

    public init(shadowColor: UIColor,
                shadowOffset: CGSize,
                shadowOpacity: Float,
                shadowRadius: CGFloat,
                cornerRadius: CGFloat) {
        self._shadowColor = shadowColor
        self._shadowOffset = shadowOffset
        self._shadowOpacity = shadowOpacity
        self._shadowRadius = shadowRadius
        self._cornerRadius = cornerRadius
        super.init(frame: .zero)
    }

    public required init?(coder aDecoder: NSCoder) { nil }

    public override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }

    private func setupShadow() {
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowColor = _shadowColor.cgColor
        self.layer.shadowOffset = _shadowOffset
        self.layer.shadowOpacity = _shadowOpacity
        self.layer.shadowRadius = _shadowRadius
        self.layer.cornerRadius = _cornerRadius
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

}
