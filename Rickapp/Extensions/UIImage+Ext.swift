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
    case galaxyImage = "galaxyImage"
    case starsImage = "starsImage"
}

extension UIImage {
    static func getImage(_ predifined: ImageNamePredifined) -> UIImage {
        return UIImage(named: predifined.rawValue) ?? UIImage(systemName: predifined.rawValue) ?? UIImage()
    }
    
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
