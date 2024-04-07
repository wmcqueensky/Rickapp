import Foundation
import UIKit

extension UIView {
    func setFontForLabels(_ labels: [UILabel], font: UIFont) {
        labels.forEach { $0.font = font }
    }
    
    func setTextColorForLabels(_ labels: [UILabel], color: UIColor) {
        labels.forEach { $0.textColor = color }
    }
}
