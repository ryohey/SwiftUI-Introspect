import SwiftUI

// TODO: we can drop this when we drop Swift 5.4, and use protocol extensions instead.
// https://github.com/apple/swift-evolution/blob/main/proposals/0299-extend-generic-static-member-lookup.md
public struct StaticMember<Base> {
    let base: Base
}

public protocol IntrospectableViewType {
    typealias Member = StaticMember<Self>
}

// MARK: SwiftUI.List

public struct IntrospectableListType: IntrospectableViewType {}

extension StaticMember where Base == IntrospectableListType {
    public static var list: Self { .init(base: .init()) }
}

// MARK: SwiftUI.NavigationStack

@available(iOS 16, tvOS 16, macOS 13, *)
public struct IntrospectableNavigationStackType: IntrospectableViewType {}

@available(iOS 16, tvOS 16, macOS 13, *)
extension StaticMember where Base == IntrospectableNavigationStackType {
    public static var navigationStack: Self { .init(base: .init()) }
}

// MARK: Platform

public struct ViewTypePlatformDescriptor<ViewType: IntrospectableViewType, PlatformView> {
    var selector: (IntrospectionUIView) -> PlatformView?
}

extension ViewTypePlatformDescriptor where ViewType == IntrospectableListType, PlatformView == UITableView {
    static var iOS: Self {
        return .init { introspectionUIView in
            nil
        }
    }
}

extension View {
    func introspect<ViewType: IntrospectableViewType, PlatformView>(
        _ viewType: ViewType.Member,
        on platform: ViewTypePlatformDescriptor<ViewType, PlatformView>,
        customize: (UIView) -> Void
    ) -> some View {
        EmptyView()
    }
}

struct Something: View {
    var body: some View {
//        EmptyView().introspect(.list, on: .iOS(.v14..<.v16)) { tableView in
//
//        }
        EmptyView().introspect(.list, on: .iOS) { tableView in
            
        }
    }
}
