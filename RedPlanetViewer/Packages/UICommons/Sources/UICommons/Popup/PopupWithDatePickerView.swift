import SwiftUI

public struct PopupWithDatePickerView: View {
    @State private var selectedDate: Date = .now
    private let model: PopupWithDatePickerModel?

    public init(
        _ model: PopupWithDatePickerModel?
    ) {
        self.model = model
        self.selectedDate = model?.selectedDate ?? .now
    }

    public var body: some View {
        buildContent()
    }

    private func buildContent() -> some View {
        VStack {
            buildHeader()
            buildDatePicker()
        }
        .padding(20.0)
        .background(
            buildBackground()
        )
    }

    private func buildHeader() -> some View {
        ActionViewHeader(
            title: model?.title ?? .empty,
            onCloseTapAction: {
                model?.onCancelTappedAction()
            },
            onAcceptTapAction: {
                model?.onSaveTappedAction(selectedDate)
            }
        )
    }

    private func buildDatePicker() -> some View {
        DatePicker(
            model?.title ?? .empty,
            selection: $selectedDate,
            in: ...Date(),
            displayedComponents: [.date]
        )
        .labelsHidden()
        .datePickerStyle(.wheel)
    }

    private func buildBackground() -> some View {
        RoundedRectangle(cornerRadius: 50.0)
            .fill(Color.backgroundOne)
            .shadow(
                color: .layerOne.opacity(0.08),
                radius: 8.0,
                x: 0.0, y: 3.0
            )
    }
}
