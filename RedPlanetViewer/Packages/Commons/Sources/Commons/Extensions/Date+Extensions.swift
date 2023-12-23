import Foundation

public enum DateFormat: String {
    case api = "yyyy-MM-dd"
    case readable = "MMMM d, yyyy"
}

public extension Date {

    func toString(format: DateFormat = .api) -> String {
        let dateFormatter: DateFormatter = .init()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}

public extension String {

    func toDate(format: DateFormat) -> Date? {
        let dateFormatter: DateFormatter = .init()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: self)
    }
}
