import Foundation

class AppNavigator: BaseNavigator {
    static let shared = AppNavigator()
    
    init() {
        super.init(with: MainRoutes.menu)
    }
    
    required init(with route: Route) {
        super.init(with: route)
    }
}
