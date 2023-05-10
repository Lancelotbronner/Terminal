//MARK: - Foreground Color

public struct ForegroundColor: Hashable, CustomStringConvertible {
	
	//MARK: Standard Colors
	
	public static let inherited = ForegroundColor(.inherited)
	
	public static let plain = ForegroundColor(.plain)
	
	public static let black = ForegroundColor(.black)
	public static let red = ForegroundColor(.red)
	public static let green = ForegroundColor(.green)
	public static let yellow = ForegroundColor(.yellow)
	public static let blue = ForegroundColor(.blue)
	public static let magenta = ForegroundColor(.magenta)
	public static let cyan = ForegroundColor(.cyan)
	public static let white = ForegroundColor(.white)
	
	public static let brightBlack = ForegroundColor(.brightBlack)
	public static let brightRed = ForegroundColor(.brightRed)
	public static let brightGreen = ForegroundColor(.brightGreen)
	public static let brightYellow = ForegroundColor(.brightYellow)
	public static let brightBlue = ForegroundColor(.brightBlue)
	public static let brightMagenta = ForegroundColor(.brightMagenta)
	public static let brightCyan = ForegroundColor(.brightCyan)
	public static let brightWhite = ForegroundColor(.brightWhite)
	
	//MARK: Properties
	
	@usableFromInline let color: ConsoleColor
	
	//MARK: Computed Properties
	
	@inlinable public var isInherited: Bool {
		color == .inherited
	}
	
	@inlinable public var description: String {
		var tmp: [UInt8] = []
		tmp.reserveCapacity(ConsoleColor.MAX_ATTRIBUTES)
		build(sequence: &tmp)
		return ControlSequence.SGR(tmp)
	}
	
	//MARK: Initialization
	
	@inlinable init(_ color: ConsoleColor) {
		self.color = color
	}
	
	@inlinable init(rgb r: UInt8, _ g: UInt8, _ b: UInt8) {
		self.init(.rgb(r, g, b))
	}
	
	//MARK: Methods
	
	@usableFromInline func build(sequence: inout [UInt8]) {
		color.build(sequence: &sequence, offset: 30)
	}
	
}
