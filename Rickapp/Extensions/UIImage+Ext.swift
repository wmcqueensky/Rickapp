import Foundation
import UIKit

enum ImageNamePredifined: String {
    case backIcon = "backIcon"
    case arrowIcon = "arrowIcon"
    case bottomArrowIcon = "bottomArrowIcon"
    case rightArrowIcon = "rightArrowIcon"
    case heartIcon = "heartIcon"
    case searchIcon = "searchIcon"
    case characterListIcon = "characterListIcon"
    case atomIcon = "atomIcon"
    case scrollUpIcon = "scrollUpIcon"
    case plusIcon = "plusIcon"
    case checkmarkIcon = "checkmarkIcon"
    case galaxyImage = "galaxyImage"
    case starsImage = "starsImage"
}

extension UIImage {
    static func getImage(_ predifined: ImageNamePredifined) -> UIImage {
        return UIImage(named: predifined.rawValue) ?? UIImage(systemName: predifined.rawValue) ?? UIImage()
    }
}
