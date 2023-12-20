import Commons
import SwiftUI

public protocol BottomSheetListener: AnyObject {
    func tapOnAccept<Value: Pickable>(_ selectedValue: Value)
}

public class BottomSheetViewModel<Value: Pickable>: ObservableObject {
    @Published public var selectedValue: Value
    public var title: String
    public var pickerValues: Array<Value>
    public var listener: BottomSheetListener?

    public init(
        with title: String,
        pickerValues: Array<Value>,
        selectedValue: Value,
        listener: BottomSheetListener?
    ) {
        self.title = title
        self.pickerValues = pickerValues
        self.selectedValue = selectedValue
        self.listener = listener
    }

    public func chooseValue() {
        listener?.tapOnAccept(selectedValue)
    }
}

extension BottomSheetViewModel: Equatable {

    public static func == (lhs: BottomSheetViewModel, rhs: BottomSheetViewModel) -> Bool {
        lhs.title == rhs.title &&
        lhs.pickerValues == rhs.pickerValues
    }
}

