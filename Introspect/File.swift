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

public struct PlatformDescriptor<SwiftUIView: ViewType, PlatformView> {}

extension PlatformDescriptor {
    static func iOS(_ versions: iOSVersionDescriptor<SwiftUIView, PlatformView>...) -> Self {
        fatalError()
    }
}

//public protocol PlatformVersionDescriptor {
//    associatedtype SwiftUIView
//}

public struct iOSVersionDescriptor<SwiftUIView: ViewType, PlatformView> {
    var selector: (IntrospectionUIView) -> PlatformView?
}

extension iOSVersionDescriptor where SwiftUIView == ListType, PlatformView == UITableView {
    static var v13: Self {
        return .init { uiView in
            nil
        }
    }

    static var v14: Self {
        return .init { uiView in
            nil
        }
    }

    static var v15: Self {
        return .init { uiView in
            nil
        }
    }
}

extension iOSVersionDescriptor where SwiftUIView == ListType, PlatformView == UICollectionView {
    static var v16: Self {
        return .init { uiView in
            nil
        }
    }
}

extension View {
    func introspect<SwiftUIView: ViewType, PlatformView>(
        _ view: SwiftUIView.Member,
        on platform: PlatformDescriptor<SwiftUIView, PlatformView>,
        customize: (PlatformView) -> Void
    ) -> some SwiftUI.View {
        EmptyView()
    }
}

struct Something: View {
    var body: some View {
//        EmptyView().introspect(.list, on: .iOS(.v14, .v15, .v16)) { tableView in
//
//        }
        EmptyView().introspect(.list, on: .iOS(.v16)) { collectionView in

        }
    }
}
