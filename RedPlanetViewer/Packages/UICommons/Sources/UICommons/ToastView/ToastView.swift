import SwiftUI

public struct ToastView: View {
    private var style: ToastStyle
    private var message: String
    private var width: CGFloat

    public init(
        style: ToastStyle,
        message: String,
        width: CGFloat = 300.0
    ) {
        self.style = style
        self.message = message
        self.width = width
    }

    public var body: some View {
        HStack(spacing: 12) {
            Image(systemName: style.iconFileName)
                .resizable()
                .foregroundColor(style.themeColor)
                .frame(width: 24.0, height: 24.0)
            Text(message)
                .foregroundColor(.layerOne)
                .font(.system(size: 14.0, weight: .medium))
            Spacer(minLength: 10)
        }
        .padding(.vertical, 8.0)
        .padding(.leading, 16.0)
        .frame(minWidth: 0, maxWidth: width)
        .background(
            RoundedRectangle(cornerRadius: 24.0)
                .stroke(lineWidth: 2.0)
                .fill(style.themeColor)
                .background(
                    RoundedRectangle(cornerRadius: 24.0)
                        .fill(Color.backgroundOne)
                )
        )
        .onAppear {
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        }
        .padding(.horizontal, 24)
    }
}
