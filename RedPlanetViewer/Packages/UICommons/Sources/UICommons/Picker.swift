import SwiftUI
import Commons

public struct Picker<Value: Pickable>: View {
    private let values: Array<Value>
    @Binding private var selectedValue: Value
    private let pickerLabel: String

    private let selectedValueFont: Font = .system(size: 22, weight: .bold)
    private let unselectedValueFont: Font = .system(size: 22)

    public init(
        values: Array<Value>,
        selectedValue: Binding<Value>,
        pickerLabel: String
    ) {
        self.values = values
        self._selectedValue = selectedValue
        self.pickerLabel = pickerLabel
    }

    public var body: some View {
        SwiftUI.Picker(
            pickerLabel,
            selection: $selectedValue
        ) {
            ForEach(values) { value in
                Text(value.rawValue)
                    .tag(value)
                    .font(
                        value == selectedValue ? selectedValueFont : unselectedValueFont
                    )
            }
        }
        .pickerStyle(.wheel)
    }
}
