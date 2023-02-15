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
    public static func iOS(_ versions: iOSVersionDescriptor<SwiftUIView, PlatformView>...) -> Self {
        fatalError()
    }
}

//public protocol PlatformVersionDescriptor {
//    associatedtype PlatformVersionType: PlatformVersion
//    associatedtype SwiftUIView: ViewType
//    associatedtype PlatformView
//
//    var platformVersion: PlatformVersionType {}
//}

public struct iOSVersionDescriptor<SwiftUIView: ViewType, PlatformView> {
    var version: Platform.iOSVersion
    var selector: (IntrospectionUIView) -> PlatformView?

    init(_ version: Platform.iOSVersion, selector: @escaping (IntrospectionUIView) -> PlatformView?) {
        self.version = version
        self.selector = selector
    }
}

extension iOSVersionDescriptor where SwiftUIView == ListType, PlatformView == UITableView {
    public static let v13 = Self(.v13) { uiView in
        nil
    }

//    public static var v13: Self {
//        return .init { uiView in
//            nil
//        }
//    }
//
//    public static var v14: Self {
//        return .init { uiView in
//            nil
//        }
//    }
//
//    public static var v15: Self {
//        return .init { uiView in
//            nil
//        }
//    }
}

extension iOSVersionDescriptor where SwiftUIView == ListType, PlatformView == UICollectionView {
//    public static var v16: Self {
//        return .init { uiView in
//            nil
//        }
//    }
}

extension View {
    public func introspect<SwiftUIView: ViewType, PlatformView>(
        _ view: SwiftUIView.Member,
        on platforms: PlatformDescriptor<SwiftUIView, PlatformView>...,
        customize: (PlatformView) -> Void
    ) -> some View {
        EmptyView()
    }
}
