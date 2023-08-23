import Foundation
import Moya
import CombineMoya

extension TargetType {
    
    var baseURL: URL {
        let baseUrlString = Bundle.main.object(forInfoDictionaryKey: "Base URL") as? String ?? ""
        return URL(string: baseUrlString)!
    }
    
    var headers: [String: String]? { return nil }
    
    var sampleData: Data { return Data() }
}
