import XCTest
import Terminal

final class StylingTests: XCTestCase {
	
	func testAPI() {
		let _ = "This text is italics red on a cyan background".red.onCyan.italic
		let _ = "So is this one but more efficient with its sequence".style(
			foreground: .red,
			background: .cyan,
			italics: .enabled)
	}
	
	func testStyleUnion() {
		XCTAssertEqual(.inherited | .inherited, ConsoleWeight.inherited)
		XCTAssertEqual(.bold | .inherited, ConsoleWeight.bold)
		XCTAssertEqual(.inherited | .bold, ConsoleWeight.bold)
		XCTAssertEqual(.bold | .dim, ConsoleWeight.bold)
		XCTAssertEqual(.dim | .bold, ConsoleWeight.dim)
	}
	
	func testStyleIntersection() {
		XCTAssertEqual(.inherited & .inherited, ConsoleWeight.inherited)
		XCTAssertEqual(.bold & .inherited, ConsoleWeight.inherited)
		XCTAssertEqual(.inherited & .bold, ConsoleWeight.inherited)
		XCTAssertEqual(.bold & .dim, ConsoleWeight.bold)
		XCTAssertEqual(.dim & .bold, ConsoleWeight.dim)
	}
	
	func testStyleSymmetricDifference() {
		XCTAssertEqual(.inherited ^ .inherited, ConsoleWeight.inherited)
		XCTAssertEqual(.bold ^ .inherited, ConsoleWeight.bold)
		XCTAssertEqual(.inherited ^ .bold, ConsoleWeight.bold)
		XCTAssertEqual(.bold ^ .dim, ConsoleWeight.inherited)
		XCTAssertEqual(.dim ^ .bold, ConsoleWeight.inherited)
	}
	
	func testTerminalCapabilities() {
		print("\(LegacySequence.CSI)31mHello\(LegacySequence.CSI)38m")
	}
	
}
