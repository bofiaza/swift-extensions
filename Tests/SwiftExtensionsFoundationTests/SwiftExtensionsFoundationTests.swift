import Foundation
import XCTest
@testable import SwiftExtensionsFoundation

final class OptionalExtensionsTests: XCTestCase {

    func testOrReturnsWrappedValue() {
        let value: Int? = 42
        XCTAssertEqual(value.or(0), 42)
    }

    func testOrReturnsDefaultWhenNil() {
        let value: String? = nil
        XCTAssertEqual(value.or("Guest"), "Guest")
    }

    func testOptionalURLOrBlank() {
        let missing: URL? = nil
        XCTAssertEqual(missing.orBlank, .blank)

        let website: URL? = URL(string: "https://example.com")
        XCTAssertEqual(website.orBlank, URL(string: "https://example.com"))
    }

    func testOptionalURLIsNotBlank() {
        XCTAssertFalse((nil as URL?).isNotBlank)
        XCTAssertFalse((URL.blank as URL?).isNotBlank)
        XCTAssertTrue((URL(string: "https://example.com") as URL?).isNotBlank)
    }
}

final class URLExtensionsTests: XCTestCase {

    func testBlank() {
        XCTAssertEqual(URL.blank.absoluteString, "about:blank")
        XCTAssertTrue(URL.blank.isBlank)
        XCTAssertFalse(URL.blank.isNotBlank)
    }

    func testNonBlank() throws {
        let url = try XCTUnwrap(URL(string: "https://example.com"))
        XCTAssertFalse(url.isBlank)
        XCTAssertTrue(url.isNotBlank)
    }
}

final class StubDefaultsTests: XCTestCase {

    func testValueProvider() {
        let provider: Provider<String> = StubDefaults.value("Hello")
        XCTAssertEqual(provider(), "Hello")
    }

    func testBoolProviders() {
        XCTAssertTrue(StubDefaults.trueProvider())
        XCTAssertFalse(StubDefaults.falseProvider())
    }

    func testCondition() {
        let alwaysTrue: Condition<String> = StubDefaults.condition(true)
        let defaultCondition: Condition<Int> = StubDefaults.condition()
        XCTAssertTrue(alwaysTrue("anything"))
        XCTAssertFalse(defaultCondition(1))
    }

    func testNoOpClosuresAreCallable() {
        let action: Action = StubDefaults.action
        let handler: Handler<Int> = StubDefaults.handler()
        action()
        handler(1)
    }
}

final class LazyDefaultAndNilOrBlankTests: XCTestCase {

    func testOrDoesNotEvaluateDefaultWhenValuePresent() {
        var evaluated = false
        func makeDefault() -> Int {
            evaluated = true
            return 0
        }
        let value: Int? = 1
        XCTAssertEqual(value.or(makeDefault()), 1)
        XCTAssertFalse(evaluated)
    }

    func testOrRethrows() {
        struct Failure: Error {}
        func failingDefault() throws -> Int { throw Failure() }
        let missing: Int? = nil
        XCTAssertThrowsError(try missing.or(failingDefault()))
        let present: Int? = 1
        XCTAssertEqual(try present.or(failingDefault()), 1)
    }

    func testIsNilOrBlank() {
        XCTAssertTrue((nil as URL?).isNilOrBlank)
        XCTAssertTrue((URL.blank as URL?).isNilOrBlank)
        XCTAssertFalse((URL(string: "https://example.com") as URL?).isNilOrBlank)
    }
}
