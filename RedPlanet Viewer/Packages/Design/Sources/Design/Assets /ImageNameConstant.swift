import SwiftUI

public struct ImageNameConstant {
    public let rawValue: String
}

extension ImageNameConstant: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }

    public init(_ string: String) {
        self.rawValue = string
    }
}
