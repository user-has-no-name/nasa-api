import Commons
import SwiftUI

public struct BottomSheetWithPickerView<Value: Pickable>: View {
    @ObservedObject private var viewModel: BottomSheetViewModel<Value>
    @Binding private var isShowing: Bool
    @State private var offset: CGFloat = 0

    init(
        isShowing: Binding<Bool>,
        viewModel: BottomSheetViewModel<Value>
    ) {
        self._viewModel = .init(initialValue: viewModel)
        self._isShowing = isShowing
    }

    public var body: some View {
        buildContent()
    }

    private func buildContent() -> some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                buildBackground()
                buildSheet()
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottom
        )
        .ignoresSafeArea()
        .animation(.easeInOut, value: viewModel)
    }

    private func buildSheet() -> some View {
        VStack {
            ActionViewHeader(
                title: viewModel.title,
                onCloseTapAction: {
                    withAnimation {
                        isShowing = false
                    }
                },
                onAcceptTapAction: {
                    withAnimation {
                        isShowing = false
                        viewModel.chooseValue()
                    }
                }
            )
            .padding([.horizontal, .top], 20.0)
            .padding(.bottom, 8.0)
            Spacer()
            Picker(
                values: viewModel.pickerValues,
                selectedValue: $viewModel.selectedValue,
                pickerLabel: viewModel.title
            )
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: UIScreen.main.bounds.height * 0.33)
        .background(.white)
        .cornerRadius(50.0, corners: .topLeft)
        .cornerRadius(50.0, corners: .topRight)
        .transition(.opacity.combined(with: .move(edge: .bottom)))
        .offset(y: max(0, offset))
        .shadow(
            color: .layerOne.opacity(0.1),
            radius: 6,
            x: 0, y: -4
        )
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation {
                        offset = value.translation.height
                    }
                }
                .onEnded { value in
                    withAnimation {
                        if offset > 50.0 {
                            isShowing = false
                        }
                        offset = 0.0
                    }
                }
        )
    }

    private func buildBackground() -> some View {
        Color.layerOne
            .opacity(0.3)
            .ignoresSafeArea()
            .onTapGesture {
                withAnimation {
                    isShowing = false
                }
            }
    }
}
