import SwiftUI

// MARK: SwiftUI.List

public struct ListType: ViewType {}

extension StaticMember where Base == ListType {
    public static var list: Self { .init(base: .init()) }
}

// MARK: SwiftUI.List - iOS

extension PlatformVersionDescriptor where Version == iOSVersion, SwiftUIView == ListType, PlatformView == UITableView {
    public static let v13 = Self(for: .v13) { customize in
        UIKitIntrospectionView(
            selector: TargetViewSelector.ancestorOrSiblingContaining,
            customize: customize
        )
    }

    public static let v14 = Self(for: .v14, sameAs: .v13)

    public static let v15 = Self(for: .v15, sameAs: .v13)
}

extension PlatformVersionDescriptor where Version == iOSVersion, SwiftUIView == ListType, PlatformView == UICollectionView {
    public static let v16 = Self(for: .v16) { customize in
        UIKitIntrospectionView(
            selector: TargetViewSelector.ancestorOrSiblingContaining,
            customize: customize
        )
    }
}

// MARK: SwiftUI.List - tvOS

extension PlatformVersionDescriptor where Version == tvOSVersion, SwiftUIView == ListType, PlatformView == UITableView {
    public static let v13 = Self(for: .v13) { customize in
        UIKitIntrospectionView(
            selector: TargetViewSelector.ancestorOrSiblingContaining,
            customize: customize
        )
    }

    public static let v14 = Self(for: .v14, sameAs: .v13)

    public static let v15 = Self(for: .v15, sameAs: .v13)
}

extension PlatformVersionDescriptor where Version == tvOSVersion, SwiftUIView == ListType, PlatformView == UICollectionView {
//    @available(*, unavailable, message: "SwiftUI.List is no longer a UIKit view on iOS 16")
    public static let v16 = unavailable(for: .v16)
}
