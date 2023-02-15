import SwiftUI

public protocol IntrospectableViewType {
    typealias Member = IntrospectableViewTypeStaticMember<Self>
}

// TODO: we can drop this when we drop Swift 5.4, and use protocol extensions instead.
// https://github.com/apple/swift-evolution/blob/main/proposals/0299-extend-generic-static-member-lookup.md
public struct IntrospectableViewTypeStaticMember<Base: IntrospectableViewType> {
    let base: Base
}

// MARK: SwiftUI.List

public struct IntrospectableListType: IntrospectableViewType {}

extension IntrospectableViewTypeStaticMember where Base == IntrospectableListType {
    public static var list: Self { .init(base: .init()) }
}

// MARK: SwiftUI.NavigationStack

@available(iOS 16, tvOS 16, macOS 13, *)
public struct IntrospectableNavigationStackType: IntrospectableViewType {}

@available(iOS 16, tvOS 16, macOS 13, *)
extension IntrospectableViewTypeStaticMember where Base == IntrospectableNavigationStackType {
    public static var navigationStack: Self { .init(base: .init()) }
}

extension View {
    func introspect<ViewType: IntrospectableViewType>(
        _ viewType: ViewType.Member,
        on platform: Platform,
        customize: (UIView) -> Void
    ) -> some View {
        EmptyView()
    }
}

struct Something: View {
    var body: some View {
        EmptyView().introspect(.list, on: .iOS(.v14)) { tableView in
            
        }
    }
}
