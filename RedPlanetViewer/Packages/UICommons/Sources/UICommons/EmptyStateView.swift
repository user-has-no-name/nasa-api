import Design
import SwiftUI

public enum EmptyStateScreen {
    case dashboard
    case history
}

public struct EmptyStateView: View {
    private let screenType: EmptyStateScreen

    public init(
        for type: EmptyStateScreen
    ) {
        screenType = type
    }

    public var body: some View {
        VStack(spacing: 20.0) {
            Image(named: .emptyStateImage)
                .frame(width: 145.0, height: 145.0)

            Text(screenType == .dashboard ?
                    "No result found.\nTry to change filters." :
                        "Browsing history is empty.")
            .multilineTextAlignment(.center)
            .font(.system(size: 16))
            .foregroundColor(.layerTwo)
        }
        .background(.clear)
    }
}


#Preview {
    Group {
        EmptyStateView(for: .dashboard)
        EmptyStateView(for: .history)
    }
}
