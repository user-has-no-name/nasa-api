import Commons
import SwiftUI

public extension View {

    func bottomSheet<Value: Pickable>(
        isShowing: Binding<Bool>,
        using viewModel: BottomSheetViewModel<Value>
    ) -> some View {
        ZStack {
            self
            BottomSheetWithPickerView<Value>(
                isShowing: isShowing,
                viewModel: viewModel
            )
        }
    }
}
