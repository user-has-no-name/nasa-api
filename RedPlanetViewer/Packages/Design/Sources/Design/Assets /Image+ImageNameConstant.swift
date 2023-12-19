import SwiftUI

public extension Image {

    init(named: ImageNameConstant) {
        self.init(
            named.rawValue,
            bundle: .module
        )
    }

    init(systemNamed: ImageNameConstant) {
        self.init(systemName: systemNamed.rawValue)
    }
}
