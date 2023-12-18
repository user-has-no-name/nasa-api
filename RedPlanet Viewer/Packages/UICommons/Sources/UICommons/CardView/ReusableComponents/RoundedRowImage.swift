import SwiftUI

struct RoundedRowImage: View {
    private let image: Image

    init(_ image: Image) {
        self.image = image
    }

    var body: some View {
        image
            .resizable()
            .frame(
                maxWidth: 130.0,
                maxHeight: 130.0
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
    }
}
