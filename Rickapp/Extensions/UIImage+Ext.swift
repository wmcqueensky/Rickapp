import Foundation
import UIKit

enum ImageNamePredifined: String {
    case backIcon = "backIcon"
    case arrowIcon = "arrowIcon"
    case heartIcon = "heartIcon"
    case characterListIcon = "characterListIcon"
    case atomIcon = "atomIcon"
    case scrollUpIcon = "scrollUpIcon"
    case galaxyImage = "galaxyImage"
    case starsImage = "starsImage"
}

extension UIImage {
    static func getImage(_ predifined: ImageNamePredifined) -> UIImage {
        return UIImage(named: predifined.rawValue) ?? UIImage(systemName: predifined.rawValue) ?? UIImage()
    }
}

