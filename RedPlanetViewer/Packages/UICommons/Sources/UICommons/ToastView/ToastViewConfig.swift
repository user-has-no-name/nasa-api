import SwiftUI

public struct Toast: Equatable {
    public var style: ToastStyle
    public var message: String
    public var duration: Double
    public var width: Double

    public init(
        style: ToastStyle,
        message: String,
        duration: Double = 3.0,
        width: Double = 350.0
    ) {
        self.style = style
        self.message = message
        self.duration = duration
        self.width = width
    }
}

public enum ToastStyle {
    case error
    case warning
    case success
    case info
}

public extension ToastStyle {

    var themeColor: Color {
        switch self {
        case .error: return .red
        case .warning: return .yellow
        case .info: return .blue
        case .success: return .green
        }
    }

    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}
