@testable import SwiftUIIntrospection
import UIKit
import XCTest

final class FindChildUsingFrameTests: XCTestCase {
    final class TargetView: UIView {}

    func test() {
        let grandparent = UIView(frame: .init(x: 0, y: 0, width: 300, height: 300))

        let parent = UIView(frame: .init(x: 100, y: 100, width: 100, height: 100)); grandparent.addSubview(parent)

        let a = TargetView(frame: .init(x: 0, y: 0, width: 50, height: 50)); parent.addSubview(a)
        let b = TargetView(frame: .init(x: 50, y: 0, width: 50, height: 50)); parent.addSubview(b)
        let c = TargetView(frame: .init(x: 0, y: 50, width: 50, height: 50)); parent.addSubview(c)
        let d = TargetView(frame: .init(x: 50, y: 50, width: 50, height: 50)); parent.addSubview(d)

        let ai = UIView(frame: .init(x: 25, y: 25, width: 0, height: 0)); parent.addSubview(ai)
        let bi = UIView(frame: .init(x: 75, y: 25, width: 0, height: 0)); parent.addSubview(bi)
        let ci = UIView(frame: .init(x: 25, y: 75, width: 0, height: 0)); parent.addSubview(ci)
        let di = UIView(frame: .init(x: 75, y: 75, width: 0, height: 0)); parent.addSubview(di)

        XCTAssertIdentical(a, grandparent.findChild(ofType: TargetView.self, usingFrameFrom: ai))
        XCTAssertIdentical(b, grandparent.findChild(ofType: TargetView.self, usingFrameFrom: bi))
        XCTAssertIdentical(c, grandparent.findChild(ofType: TargetView.self, usingFrameFrom: ci))
        XCTAssertIdentical(d, grandparent.findChild(ofType: TargetView.self, usingFrameFrom: di))
    }
}
