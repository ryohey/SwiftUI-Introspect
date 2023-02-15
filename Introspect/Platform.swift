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
            if #available(iOS 14, *) {
                return false
            }
            if #available(iOS 13, *) {
                return true
            }
        case .iOS(.v14):
            if #available(iOS 15, *) {
                return false
            }
            if #available(iOS 14, *) {
                return true
            }
        case .iOS(.v15):
            if #available(iOS 16, *) {
                return false
            }
            if #available(iOS 15, *) {
                return true
            }
        case .iOS(.v16):
            if #available(iOS 17, *) {
                return false
            }
            if #available(iOS 16, *) {
                return true
            }
        case .macOS(.v10_15):
            if #available(macOS 11, *) {
                return false
            }
            if #available(macOS 10.15, *) {
                return true
            }
        case .macOS(.v11):
            if #available(macOS 12, *) {
                return false
            }
            if #available(macOS 11, *) {
                return true
            }
        case .macOS(.v12):
            if #available(macOS 13, *) {
                return false
            }
            if #available(macOS 12, *) {
                return true
            }
        case .macOS(.v13):
            if #available(macOS 14, *) {
                return false
            }
            if #available(macOS 13, *) {
                return true
            }
        case .tvOS(.v13):
            if #available(tvOS 14, *) {
                return false
            }
            if #available(tvOS 13, *) {
                return true
            }
        case .tvOS(.v14):
            if #available(tvOS 15, *) {
                return false
            }
            if #available(tvOS 14, *) {
                return true
            }
        case .tvOS(.v15):
            if #available(tvOS 16, *) {
                return false
            }
            if #available(tvOS 15, *) {
                return true
            }
        case .tvOS(.v16):
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
