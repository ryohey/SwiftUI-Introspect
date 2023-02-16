import Introspect
import SwiftUI
import XCTest

final class NewAPITests: XCTestCase {
    func testList() {
        struct TestListView: View {
            let spy: () -> Void

            var body: some View {
                List {
                    Text("Item 1")
                    Text("Item 2")
                }
//                #if os(iOS) || os(tvOS)
//                .introspect(.list, on: .iOS(.v13, .v14, .v15), .tvOS(.v13, .v14, .v15)) { tableView in
//                    spy()
//                }
//                .introspect(.list, on: .iOS(.v16)) { collectionView in
//                    spy()
//                }
//                #elseif os(macOS)
//                .introspect(.list, on: .macOS(.v10_15, .v11, .v12, .v13)) { tableView in
//                    spy()
//                }
//                #endif
                .modify {

                }
                .introspect(.navigationStack, on: .iOS(.v16)) { s in
                    
                }
            }
        }

        if Platform.tvOS(.v16).isCurrent {
            return // TODO: verify whether List no longer uses a UIKit view under the hood in tvOS 16
        }

        let expectation1 = XCTestExpectation()

        let view = TestListView(
            spy: { expectation1.fulfill() }
        )
        TestUtils.present(view: view)
        wait(for: [expectation1], timeout: TestUtils.Constants.timeout)
    }
}
