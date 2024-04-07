import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { view in
            addArrangedSubview(view)
        }
    }
    
    func removeArrangedSubviews() {
        self.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    func setEdgeInsets(top: CGFloat = 0.0, left: CGFloat = 0.0, bottom: CGFloat = 0.0, right: CGFloat = 0.0) {
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    func insertArrangedSubview(_ view: UIView, belowArrangedSubview subview: UIView) {
        arrangedSubviews.enumerated().forEach {
            if $0.1 == subview {
                insertArrangedSubview(view, at: $0.0 + 1)
            }
        }
    }
    
    func insertArrangedSubview(_ view: UIView, aboveArrangedSubview subview: UIView) {
        arrangedSubviews.enumerated().forEach {
            if $0.1 == subview {
                insertArrangedSubview(view, at: $0.0)
            }
        }
    }
    
    func setCustomSpacings(_ spacing: CGFloat, _ subviews: [UIView]) {
        arrangedSubviews
            .filter { subviews.contains($0) }
            .forEach { setCustomSpacing(spacing, after: $0) }
    }
}
