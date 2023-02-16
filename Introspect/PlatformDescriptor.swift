import SwiftUI

public struct PlatformDescriptor<SwiftUIView: ViewType, PlatformView> {
    typealias IntrospectingView = (@escaping (PlatformView) -> Void) -> AnyView

    let introspectingView: IntrospectingView?
}

extension PlatformDescriptor {
    public static func iOS(_ versions: PlatformVersionDescriptor<iOSVersion, SwiftUIView, PlatformView>...) -> Self {
        Self(introspectingView: versions.lazy.compactMap(\.introspectingView).first)
    }

    public static func macOS(_ versions: PlatformVersionDescriptor<macOSVersion, SwiftUIView, PlatformView>...) -> Self {
        Self(introspectingView: versions.lazy.compactMap(\.introspectingView).first)
    }

    public static func tvOS(_ versions: PlatformVersionDescriptor<tvOSVersion, SwiftUIView, PlatformView>...) -> Self {
        Self(introspectingView: versions.lazy.compactMap(\.introspectingView).first)
    }
}

public struct PlatformVersionDescriptor<Version: PlatformVersion, SwiftUIView: ViewType, PlatformView> {
    typealias IntrospectingView = (@escaping (PlatformView) -> Void) -> AnyView

    private let version: Version
    private let _introspectingView: IntrospectingView

    init<IntrospectingView: View>(
        for version: Version,
        introspectingView: @escaping (@escaping (PlatformView) -> Void) -> IntrospectingView
    ) {
        self.version = version
        self._introspectingView = { customize in AnyView(introspectingView(customize)) }
    }

    init(
        for version: Version,
        sameAs other: Self
    ) {
        self.init(for: version, introspectingView: other._introspectingView)
    }

    static func unavailable(for version: Version, file: StaticString = #file, line: UInt = #line) -> Self {
        runtimeWarn(
            """
            If you're seeing this, someone forgot to mark \(file):\(line) as unavailable.

            This results in a no-op, but should probably be reported upstream for fixing.

            Please use the following link to automatically file a GitHub issue:

            - https://github.com/siteline/SwiftUI-Introspect/issues/new?title=\(file):\(line)
            """
        )
        return Self(for: version) { _ in EmptyView() }
    }

    var introspectingView: IntrospectingView? {
        if version.isCurrent {
            return _introspectingView
        } else {
            return nil
        }
    }
}
