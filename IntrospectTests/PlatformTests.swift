@testable import Introspect
import XCTest

final class PlatformTests: XCTestCase {
    func test_iOS() {
        #if os(iOS)
        if #available(iOS 16, *) {
            XCTAssertEqual(Platform.iOS(.v16).isCurrent, true)
            XCTAssertEqual(Platform.iOS(.v15).isCurrent, false)
            XCTAssertEqual(Platform.iOS(.v14).isCurrent, false)
            XCTAssertEqual(Platform.iOS(.v13).isCurrent, false)
        } else if #available(iOS 15, *) {
            XCTAssertEqual(Platform.iOS(.v16).isCurrent, false)
            XCTAssertEqual(Platform.iOS(.v15).isCurrent, true)
            XCTAssertEqual(Platform.iOS(.v14).isCurrent, false)
            XCTAssertEqual(Platform.iOS(.v13).isCurrent, false)
        } else if #available(iOS 14, *) {
            XCTAssertEqual(Platform.iOS(.v16).isCurrent, false)
            XCTAssertEqual(Platform.iOS(.v15).isCurrent, false)
            XCTAssertEqual(Platform.iOS(.v14).isCurrent, true)
            XCTAssertEqual(Platform.iOS(.v13).isCurrent, false)
        } else if #available(iOS 13, *) {
            XCTAssertEqual(Platform.iOS(.v16).isCurrent, false)
            XCTAssertEqual(Platform.iOS(.v15).isCurrent, false)
            XCTAssertEqual(Platform.iOS(.v14).isCurrent, false)
            XCTAssertEqual(Platform.iOS(.v13).isCurrent, true)
        }
        #else
        XCTAssertEqual(Platform.iOS(.v16).isCurrent, false)
        XCTAssertEqual(Platform.iOS(.v15).isCurrent, false)
        XCTAssertEqual(Platform.iOS(.v14).isCurrent, false)
        XCTAssertEqual(Platform.iOS(.v13).isCurrent, false)
        #endif
    }

    func test_iOS_Range() {
        let sut: CountableRange<Platform.iOSVersion> = .v13 ..< .v16
        XCTAssertEqual(Array(sut), [.v13, .v14, .v15])
    }

    func test_iOS_ClosedRange() {
        let sut: CountableClosedRange<Platform.iOSVersion> = .v13 ... .v16
        XCTAssertEqual(Array(sut), [.v13, .v14, .v15, .v16])
    }

    func test_macOS() {
        #if os(macOS)
        if #available(macOS 13, *) {
            XCTAssertEqual(Platform.macOS(.v13).isCurrent, true)
            XCTAssertEqual(Platform.macOS(.v12).isCurrent, false)
            XCTAssertEqual(Platform.macOS(.v11).isCurrent, false)
            XCTAssertEqual(Platform.macOS(.v10_15).isCurrent, false)
        } else if #available(macOS 12, *) {
            XCTAssertEqual(Platform.macOS(.v13).isCurrent, false)
            XCTAssertEqual(Platform.macOS(.v12).isCurrent, true)
            XCTAssertEqual(Platform.macOS(.v11).isCurrent, false)
            XCTAssertEqual(Platform.macOS(.v10_15).isCurrent, false)
        } else if #available(macOS 11, *) {
            XCTAssertEqual(Platform.macOS(.v13).isCurrent, false)
            XCTAssertEqual(Platform.macOS(.v12).isCurrent, false)
            XCTAssertEqual(Platform.macOS(.v11).isCurrent, true)
            XCTAssertEqual(Platform.macOS(.v10_15).isCurrent, false)
        } else if #available(macOS 10.15, *) {
            XCTAssertEqual(Platform.macOS(.v13).isCurrent, false)
            XCTAssertEqual(Platform.macOS(.v12).isCurrent, false)
            XCTAssertEqual(Platform.macOS(.v11).isCurrent, false)
            XCTAssertEqual(Platform.macOS(.v10_15).isCurrent, true)
        }
        #else
        XCTAssertEqual(Platform.macOS(.v13).isCurrent, false)
        XCTAssertEqual(Platform.macOS(.v12).isCurrent, false)
        XCTAssertEqual(Platform.macOS(.v11).isCurrent, false)
        XCTAssertEqual(Platform.macOS(.v10_15).isCurrent, false)
        #endif
    }

    func test_macOS_Range() {
        let sut: CountableRange<Platform.macOSVersion> = .v10_15 ..< .v13
        XCTAssertEqual(Array(sut), [.v10_15, .v11, .v12])
    }

    func test_macOS_ClosedRange() {
        let sut: CountableClosedRange<Platform.macOSVersion> = .v10_15 ... .v13
        XCTAssertEqual(Array(sut), [.v10_15, .v11, .v12, .v13])
    }

    func test_tvOS() {
        #if os(tvOS)
        if #available(tvOS 16, *) {
            XCTAssertEqual(Platform.tvOS(.v16).isCurrent, true)
            XCTAssertEqual(Platform.tvOS(.v15).isCurrent, false)
            XCTAssertEqual(Platform.tvOS(.v14).isCurrent, false)
            XCTAssertEqual(Platform.tvOS(.v13).isCurrent, false)
        } else if #available(tvOS 15, *) {
            XCTAssertEqual(Platform.tvOS(.v16).isCurrent, false)
            XCTAssertEqual(Platform.tvOS(.v15).isCurrent, true)
            XCTAssertEqual(Platform.tvOS(.v14).isCurrent, false)
            XCTAssertEqual(Platform.tvOS(.v13).isCurrent, false)
        } else if #available(tvOS 14, *) {
            XCTAssertEqual(Platform.tvOS(.v16).isCurrent, false)
            XCTAssertEqual(Platform.tvOS(.v15).isCurrent, false)
            XCTAssertEqual(Platform.tvOS(.v14).isCurrent, true)
            XCTAssertEqual(Platform.tvOS(.v13).isCurrent, false)
        } else if #available(tvOS 13, *) {
            XCTAssertEqual(Platform.tvOS(.v16).isCurrent, false)
            XCTAssertEqual(Platform.tvOS(.v15).isCurrent, false)
            XCTAssertEqual(Platform.tvOS(.v14).isCurrent, false)
            XCTAssertEqual(Platform.tvOS(.v13).isCurrent, true)
        }
        #else
        XCTAssertEqual(Platform.tvOS(.v16).isCurrent, false)
        XCTAssertEqual(Platform.tvOS(.v15).isCurrent, false)
        XCTAssertEqual(Platform.tvOS(.v14).isCurrent, false)
        XCTAssertEqual(Platform.tvOS(.v13).isCurrent, false)
        #endif
    }

    func test_tvOS_Range() {
        let sut: CountableRange<Platform.tvOSVersion> = .v13 ..< .v16
        XCTAssertEqual(Array(sut), [.v13, .v14, .v15])
    }

    func test_tvOS_ClosedRange() {
        let sut: CountableClosedRange<Platform.tvOSVersion> = .v13 ... .v16
        XCTAssertEqual(Array(sut), [.v13, .v14, .v15, .v16])
    }
}
