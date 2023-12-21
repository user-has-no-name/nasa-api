import Commons
import Foundation

public struct PopupWithDatePickerModel: ComponentPresentable {
    public let title: String
    public let selectedDate: Date
    public let onSaveTappedAction: (Date) -> Void
    public let onCancelTappedAction: () -> Void

    public init(
        title: String,
        selectedDate: Date,
        onSaveTappedAction: @escaping (Date) -> Void,
        onCancelTappedAction: @escaping () -> Void
    ) {
        self.title = title
        self.selectedDate = selectedDate
        self.onSaveTappedAction = onSaveTappedAction
        self.onCancelTappedAction = onCancelTappedAction
    }
}
