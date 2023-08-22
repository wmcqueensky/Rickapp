import Foundation
import UIKit

enum ImageNamePredifined: String {
    case greenStatus = "greenStatus"
    case redStatus = "redStatus"
    case grayStatus = "grayStatus"
}

extension UIImage {
    static func getImage(_ predifined: ImageNamePredifined) -> UIImage {
        return UIImage(named: predifined.rawValue) ?? UIImage(systemName: predifined.rawValue) ?? UIImage()
    }
}
