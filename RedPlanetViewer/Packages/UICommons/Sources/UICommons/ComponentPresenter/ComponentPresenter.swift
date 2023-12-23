import SwiftUI
import Commons

struct ComponentPresenter<PopupContent, Config>: ViewModifier where PopupContent: View,
                                                                    Config: ComponentPresentable {
    // Controls if the component should be presented or not
    @Binding private var config: Config?

    private let view: () -> PopupContent
    private let onDismiss: (() -> ())?
    private let allowToCloseOnTapBackground: Bool

    @State private var presenterContentRect: CGRect = .zero
    @State private var sheetContentRect: CGRect = .zero

    private var displayedOffset: CGFloat {
        -presenterContentRect.midY + screenHeight / 2
    }

    private var hiddenOffset: CGFloat {
        screenHeight
    }

    private var currentOffset: CGFloat {
        config != nil ? displayedOffset : hiddenOffset
    }

    private var screenWidth: CGFloat {
        UIScreen.main.bounds.size.width
    }

    private var screenHeight: CGFloat {
        UIScreen.main.bounds.size.height
    }

    init(
        config: Binding<Config?>,
        view: @escaping () -> PopupContent,
        allowToCloseOnTapBackground: Bool,
        onDismiss: (() -> ())? = nil
    ) {
        self._config = config
        self.view = view
        self.allowToCloseOnTapBackground = allowToCloseOnTapBackground
        self.onDismiss = onDismiss
    }

    func body(content: Content) -> some View {
        ZStack {
            content
                .frameGetter($presenterContentRect)
        }
        .overlay(buildSheet())
    }

    private func buildSheet() -> some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                self.view()
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            if allowToCloseOnTapBackground {
                                dismiss()
                            }
                        }
                    )
                    .frame(width: screenWidth)
                    .offset(x: 0.0, y: currentOffset)
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.async {
                    self.presenterContentRect = proxy.frame(in: .global)
                }
            }
            .onChange(of: currentOffset) { _ in
                if currentOffset == hiddenOffset {
                    dismiss()
                }
            }
        }
    }

    private func dismiss() {
        config = nil
        onDismiss?()
    }
}

fileprivate extension View {

    func frameGetter(_ frame: Binding<CGRect>) -> some View {
        modifier(FrameGetter(frame: frame))
    }
}

fileprivate struct FrameGetter: ViewModifier {
    @Binding var frame: CGRect

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy -> AnyView in
                    let rect = proxy.frame(in: .global)
                    // To avoid an infinite layout loop
                    if rect.integral != self.frame.integral {
                        DispatchQueue.main.async {
                            self.frame = rect
                        }
                    }
                    return AnyView(EmptyView())
                }
            )
    }
}
