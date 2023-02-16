import SwiftUI

// MARK: SwiftUI.NavigationStack

@available(iOS 16, tvOS 16, macOS 13, *)
public struct NavigationStackType: ViewType {}

@available(iOS 16, tvOS 16, macOS 13, *)
extension StaticMember where Base == NavigationStackType {
    public static var navigationStack: Self { .init(base: .init()) }
}

// TODO
