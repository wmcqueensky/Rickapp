import UIKit

extension UITableView {
    func reloadData(withCharacters characters: [Character]?) {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
