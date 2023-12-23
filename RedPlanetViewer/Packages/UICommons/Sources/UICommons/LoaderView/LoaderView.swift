import Animation
import SwiftUI

public struct LoaderView: View {
    public init() {}
    public var body: some View {
        VStack {
            LottieView(
                animationConfiguration: .loader,
                contentMode: .scaleAspectFill
            )
            .frame(maxWidth: 100.0, maxHeight: 50.0)
            Text("Loading")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.layerOne)
                .offset(y: -8)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: .layerOne.opacity(0.1), radius: 27.5, x: 0, y: 20)
        }
    }
}
