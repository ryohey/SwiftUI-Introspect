import Foundation

protocol PlatformVersion: RawRepresentable, Comparable, Strideable where RawValue == Int, Stride == Int {
    var isCurrent: Bool { get }
}

extension PlatformVersion {
    func advanced(by n: Int) -> Self {
        guard let instance = Self(rawValue: self.rawValue.advanced(by: n)) else {
            fatalError("Calling advanced(by:) on PlatformVersion is unsafe and highly discouraged.")
        }
        return instance
    }

    func distance(to other: Self) -> Int {
        self.rawValue.distance(to: other.rawValue)
    }
}

enum Platform {
    case iOS(iOSVersion)
    case macOS(macOSVersion)
    case tvOS(tvOSVersion)

    enum iOSVersion: Int, PlatformVersion {
        case v13, v14, v15, v16
    }

    enum macOSVersion: Int, PlatformVersion {
        case v10_15, v11, v12, v13
    }

    enum tvOSVersion: Int, PlatformVersion {
        case v13, v14, v15, v16
    }

    var isCurrent: Bool {
        switch self {
        case .iOS(let version):
            return version.isCurrent
        case .macOS(let version):
            return version.isCurrent
        case .tvOS(let version):
            return version.isCurrent
        }
    }
}

extension Platform.iOSVersion {
    var isCurrent: Bool {
        switch self {
        case .v13:
            if #available(iOS 14, *) {
                return false
            }
            if #available(iOS 13, *) {
                return true
            }
        case .v14:
            if #available(iOS 15, *) {
                return false
            }
            if #available(iOS 14, *) {
                return true
            }
        case .v15:
            if #available(iOS 16, *) {
                return false
            }
            if #available(iOS 15, *) {
                return true
            }
        case .v16:
            if #available(iOS 17, *) {
                return false
            }
            if #available(iOS 16, *) {
                return true
            }
        }
        return false
    }
}

extension Platform.macOSVersion {
    var isCurrent: Bool {
        switch self {
        case .v10_15:
            if #available(macOS 11, *) {
                return false
            }
            if #available(macOS 10.15, *) {
                return true
            }
        case .v11:
            if #available(macOS 12, *) {
                return false
            }
            if #available(macOS 11, *) {
                return true
            }
        case .v12:
            if #available(macOS 13, *) {
                return false
            }
            if #available(macOS 12, *) {
                return true
            }
        case .v13:
            if #available(macOS 14, *) {
                return false
            }
            if #available(macOS 13, *) {
                return true
            }
        }
        return false
    }
}

extension Platform.tvOSVersion {
    var isCurrent: Bool {
        switch self {
        case .v13:
            if #available(tvOS 14, *) {
                return false
            }
            if #available(tvOS 13, *) {
                return true
            }
        case .v14:
            if #available(tvOS 15, *) {
                return false
            }
            if #available(tvOS 14, *) {
                return true
            }
        case .v15:
            if #available(tvOS 16, *) {
                return false
            }
            if #available(tvOS 15, *) {
                return true
            }
        case .v16:
            if #available(tvOS 17, *) {
                return false
            }
            if #available(tvOS 16, *) {
                return true
            }
        }
        return false
    }
}
