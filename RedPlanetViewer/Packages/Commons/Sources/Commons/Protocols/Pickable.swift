public protocol Pickable: Identifiable, CaseIterable, Hashable {
    var rawValue: String { get }
    static var defaultValue: Self { get }
}