import Foundation

public enum DateFormat: String {
    case api = "yyyy-MM-dd"
}

public extension Date {
    func toString(format: String = DateFormat.api.rawValue) -> String {
        let dateFormatter: DateFormatter = .init()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
