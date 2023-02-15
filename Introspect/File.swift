import SwiftUI

public protocol ViewType {
    typealias Member = StaticMember<Self>
}

// TODO: we can drop this when we drop Swift 5.4, and use protocol extensions instead.
// https://github.com/apple/swift-evolution/blob/main/proposals/0299-extend-generic-static-member-lookup.md
public struct StaticMember<Base> {
    let base: Base
}

// MARK: SwiftUI.List

public struct ListType: ViewType {}

extension StaticMember where Base == ListType {
    public static var list: Self { .init(base: .init()) }
}

// MARK: SwiftUI.NavigationStack

@available(iOS 16, tvOS 16, macOS 13, *)
public struct NavigationStackType: ViewType {}

@available(iOS 16, tvOS 16, macOS 13, *)
extension StaticMember where Base == NavigationStackType {
    public static var navigationStack: Self { .init(base: .init()) }
}

// MARK: Platforms

public struct PlatformViewDescriptor<SwiftUIView: ViewType, PlatformView> {
    var selector: (IntrospectionUIView) -> PlatformView?
}

extension PlatformViewDescriptor where SwiftUIView == ListType, PlatformView == UITableView {
    static var iOS: Self {
        return .init { introspectionUIView in
            nil
        }
    }
}

extension View {
    func introspect<SwiftUIView: ViewType, PlatformView>(
        _ view: SwiftUIView.Member,
        on platform: PlatformViewDescriptor<SwiftUIView, PlatformView>,
        customize: (UIView) -> Void
    ) -> some SwiftUI.View {
        EmptyView()
    }
}

struct Something: View {
    var body: some View {
//        EmptyView().introspect(.list, on: .iOS(.v14, .v15, .v16)) { tableView in
//
//        }
        EmptyView().introspect(.list, on: .iOS) { tableView in
            
        }
    }
}
