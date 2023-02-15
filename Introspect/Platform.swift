import Foundation

enum Platform {
    case iOS(iOSPlatformVersion)
    case macOS(macOSPlatformVersion)
    case tvOS(tvOSPlatformVersion)

    enum iOSPlatformVersion {
        case v13, v14, v15, v16
    }

    enum macOSPlatformVersion {
        case v10_15, v11, v12, v13
    }

    enum tvOSPlatformVersion {
        case v13, v14, v15, v16
    }

    var isCurrent: Bool {
        switch self {
        case .iOS(.v13):
            #if os(iOS)
            if #available(iOS 14, *) {
                return false
            }
            if #available(iOS 13, *) {
                return true
            }
            #else
            return false
            #endif
        case .iOS(.v14):
            #if os(iOS)
            if #available(iOS 15, *) {
                return false
            }
            if #available(iOS 14, *) {
                return true
            }
            #else
            return false
            #endif
        case .iOS(.v15):
            #if os(iOS)
            if #available(iOS 16, *) {
                return false
            }
            if #available(iOS 15, *) {
                return true
            }
            #else
            return false
            #endif
        case .iOS(.v16):
            #if os(iOS)
            if #available(iOS 17, *) {
                return false
            }
            if #available(iOS 16, *) {
                return true
            }
            #else
            return false
            #endif
        case .macOS(.v10_15):
            #if os(macOS)
            if #available(macOS 11, *) {
                return false
            }
            if #available(macOS 10.15, *) {
                return true
            }
            #else
            return false
            #endif
        case .macOS(.v11):
            #if os(macOS)
            if #available(macOS 12, *) {
                return false
            }
            if #available(macOS 11, *) {
                return true
            }
            #else
            return false
            #endif
        case .macOS(.v12):
            #if os(macOS)
            if #available(macOS 13, *) {
                return false
            }
            if #available(macOS 12, *) {
                return true
            }
            #else
            return false
            #endif
        case .macOS(.v13):
            #if os(macOS)
            if #available(macOS 14, *) {
                return false
            }
            if #available(macOS 13, *) {
                return true
            }
            #else
            return false
            #endif
        case .tvOS(.v13):
            #if os(tvOS)
            if #available(tvOS 14, *) {
                return false
            }
            if #available(tvOS 13, *) {
                return true
            }
            #else
            return false
            #endif
        case .tvOS(.v14):
            #if os(tvOS)
            if #available(tvOS 15, *) {
                return false
            }
            if #available(tvOS 14, *) {
                return true
            }
            #else
            return false
            #endif
        case .tvOS(.v15):
            #if os(tvOS)
            if #available(tvOS 16, *) {
                return false
            }
            if #available(tvOS 15, *) {
                return true
            }
            #else
            return false
            #endif
        case .tvOS(.v16):
            #if os(tvOS)
            if #available(tvOS 17, *) {
                return false
            }
            if #available(tvOS 16, *) {
                return true
            }
            #else
            return false
            #endif
        }
        return false
    }
}
