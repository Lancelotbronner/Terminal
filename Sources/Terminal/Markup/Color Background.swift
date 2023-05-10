//MARK: - Background Color

public struct BackgroundColor: Hashable {
	
	//MARK: Standard Colors
	
	public static let inherited = BackgroundColor(.inherited)
	
	public static let plain = BackgroundColor(.plain)
	
	public static let black = BackgroundColor(.black)
	public static let red = BackgroundColor(.red)
	public static let green = BackgroundColor(.green)
	public static let yellow = BackgroundColor(.yellow)
	public static let blue = BackgroundColor(.blue)
	public static let magenta = BackgroundColor(.magenta)
	public static let cyan = BackgroundColor(.cyan)
	public static let white = BackgroundColor(.white)
	
	public static let brightBlack = BackgroundColor(.brightBlack)
	public static let brightRed = BackgroundColor(.brightRed)
	public static let brightGreen = BackgroundColor(.brightGreen)
	public static let brightYellow = BackgroundColor(.brightYellow)
	public static let brightBlue = BackgroundColor(.brightBlue)
	public static let brightMagenta = BackgroundColor(.brightMagenta)
	public static let brightCyan = BackgroundColor(.brightCyan)
	public static let brightWhite = BackgroundColor(.brightWhite)
	
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
		color.build(sequence: &sequence, offset: 40)
	}
	
}
