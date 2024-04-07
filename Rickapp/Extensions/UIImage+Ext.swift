import Foundation
import UIKit

enum ImageNamePredifined: String {
    case backIcon = "backIcon"
    case heartIconSelected = "heartIconSelected"
    case heartIconUnselected = "heartIconUnselected"
    case characterListIcon = "characterListIcon"
}

extension UIImage {
    static func getImage(_ predifined: ImageNamePredifined) -> UIImage {
        return UIImage(named: predifined.rawValue) ?? UIImage(systemName: predifined.rawValue) ?? UIImage()
    }
}

