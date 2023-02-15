@testable import Introspect
import SwiftUI
import XCTest

final class NewAPITests: XCTestCase {
    func testList() {
        struct TestListView: View {
            var body: some View {
                List {

                }
                #if os(iOS)
                .introspect(.list, on: .iOS(.v13, .v14, .v15)) { tableView in
                    print(tableView)
                }
                .introspect(.list, on: .iOS(.v16)) { collectionView in
                    print(collectionView)
                }
                #endif
            }
        }
    }
}
