import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct RefreshableScrollView: UIViewRepresentable {
    public typealias UIViewType = UIView
    
    @Binding var isRefreshing: Bool
    let action: (() -> Void)?
    
    public init(isRefreshing: Binding<Bool>, action: (() -> Void)? = nil) {
        _isRefreshing = isRefreshing
        self.action = action
    }
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView.init(frame: .zero)
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            guard let view = uiView.superview?.superview else {
                return
            }
            guard let scrollView = getScrollView(view) else {
                return
            }
            if let refreshControl = scrollView.refreshControl {
                if self.isRefreshing {
                    refreshControl.beginRefreshing()
                } else {
                    refreshControl.endRefreshing()
                }
            } else {
                let refreshControl = UIRefreshControl()
                scrollView.refreshControl = refreshControl
                scrollView.delegate = context.coordinator
            }
        }
    }
    
    private func getScrollView(_ root: UIView) -> UIScrollView? {
        for subview in root.subviews {
            if subview is UIScrollView {
                return subview as? UIScrollView
            } else if let scrollView = getScrollView(subview) {
                return scrollView
            }
        }
        return nil
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator($isRefreshing, action: action)
    }
    
    public class Coordinator: NSObject, UIScrollViewDelegate {
        
        var isRefreshing: Binding<Bool>
        var action: (() -> Void)?
        
        init(_ isRefreshing: Binding<Bool>, action: (() -> Void)?) {
            self.isRefreshing = isRefreshing
            self.action = action
        }
        
        public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if isRefreshing.wrappedValue {
                return
            }
            if let refreshControl = scrollView.refreshControl, refreshControl.isRefreshing {
                isRefreshing.wrappedValue = true
                self.action?()
            }
        }
    }
}
