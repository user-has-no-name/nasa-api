import Commons

public protocol LoaderPresentable: AnyObject {
    var loaderConfig: LoaderConfiguration? { get set }
    func showLoader()
    func removeLoader()
    func loaderIsPresented() -> Bool
}

public extension LoaderPresentable {

    @MainActor
    func showLoader() {
        loaderConfig = .init()
    }

    @MainActor
    func removeLoader() {
        loaderConfig = nil
    }

    @MainActor
    func loaderIsPresented() -> Bool {
        loaderConfig != nil
    }
}
