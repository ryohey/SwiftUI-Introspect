#if canImport(UIKit)
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
                #if os(iOS)
                .introspect(.list, on: .iOS(.v13, .v14, .v15)) { tableView in
                    spy()
                }
                .introspect(.list, on: .iOS(.v16)) { collectionView in
                    spy()
                }
                #endif
            }
        }

        let expectation1 = XCTestExpectation()

        let view = TestListView(
            spy: { expectation1.fulfill() }
        )
        TestUtils.present(view: view)
        wait(for: [expectation1], timeout: TestUtils.Constants.timeout)
    }
}
#endif
