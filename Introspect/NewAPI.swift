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

public struct PlatformDescriptor<SwiftUIView: ViewType, PlatformView> {
    typealias IntrospectingView = (@escaping (PlatformView) -> Void) -> AnyView

    let introspectingView: IntrospectingView?
}

extension PlatformDescriptor {
    public static func iOS(_ versions: PlatformVersionDescriptor<iOSVersion, SwiftUIView, PlatformView>...) -> Self {
        Self(introspectingView: versions.lazy.compactMap(\.introspectingView).first)
    }
}

public struct PlatformVersionDescriptor<Version: PlatformVersion, SwiftUIView: ViewType, PlatformView> {
    typealias IntrospectingView = (@escaping (PlatformView) -> Void) -> AnyView

    private let version: Version
    private let _introspectingView: IntrospectingView

    init<IntrospectingView: View>(
        _ version: Version,
        introspectingView: @escaping (@escaping (PlatformView) -> Void) -> IntrospectingView
    ) {
        self.version = version
        self._introspectingView = { customize in AnyView(introspectingView(customize)) }
    }

    var introspectingView: IntrospectingView? {
        if version.isCurrent {
            return _introspectingView
        } else {
            return nil
        }
    }

    static func sameAs(_ other: Self, for version: Version) -> Self {
        Self(version, introspectingView: other._introspectingView)
    }
}

extension PlatformVersionDescriptor where Version == iOSVersion, SwiftUIView == ListType, PlatformView == UITableView {
    public static let v13 = Self(.v13) { customize in
        UIKitIntrospectionView(
            selector: TargetViewSelector.ancestorOrSiblingContaining,
            customize: customize
        )
    }

    public static let v14 = sameAs(.v13, for: .v14)

    public static let v15 = sameAs(.v13, for: .v15)
}

extension PlatformVersionDescriptor where Version == iOSVersion, SwiftUIView == ListType, PlatformView == UICollectionView {
//    public static var v16: Self {
//        return .init { uiView in
//            nil
//        }
//    }
}

extension View {
    @ViewBuilder
    public func introspect<SwiftUIView: ViewType, PlatformView>(
        _ view: SwiftUIView.Member,
        on platforms: PlatformDescriptor<SwiftUIView, PlatformView>...,
        customize: @escaping (PlatformView) -> Void
    ) -> some View {
        if let introspectingView = platforms.lazy.compactMap(\.introspectingView).first {
            self.inject(introspectingView(customize))
        } else {
            self
        }
    }
}
