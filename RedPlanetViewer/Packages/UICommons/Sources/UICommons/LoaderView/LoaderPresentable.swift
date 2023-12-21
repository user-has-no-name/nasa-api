import Commons

public protocol LoaderPresentable: AnyObject {
    var loaderConfig: LoaderConfiguration? { get set }
    func showLoader()
    func removeLoader()
    func loaderIsPresented() -> Bool
}

public extension LoaderPresentable {

    func showLoader() {
        loaderConfig = .init()
    }

    func removeLoader() {
        loaderConfig = nil
    }

    func loaderIsPresented() -> Bool {
        loaderConfig != nil
    }
}
