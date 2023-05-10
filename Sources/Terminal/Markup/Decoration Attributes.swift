//MARK: - Console Weight

public struct ConsoleWeight: _ConsoleDecorationAttribute {
	
	//MARK: Constants
	
	public static let inherited = ConsoleWeight(0)
	
	public static let regular = ConsoleWeight(0x1)
	public static let bold = ConsoleWeight(0x3)
	public static let dim = ConsoleWeight(0x5)
	
	//MARK: Attribute
	
	@usableFromInline static let mask: UInt16 = 0x7
	
	@usableFromInline let rawValue: UInt16
	
	@usableFromInline init(_ rawValue: UInt16) {
		self.rawValue = rawValue
	}
	
	//MARK: Computed Properties
	
	@usableFromInline var code: UInt8? {
		switch self {
		case .regular: return 22
		case .bold: return 1
		case .dim: return 2
		default: return fallback
		}
	}
	
}

//MARK: - Console Italics

public struct ConsoleItalics: _ConsoleDecorationAttribute {
	
	//MARK: Constants
	
	public static let inherited = ConsoleItalics(0)
	
	public static let disabled = ConsoleItalics(0x8)
	public static let enabled = ConsoleItalics(0x18)
	
	//MARK: Attribute
	
	@usableFromInline static let mask: UInt16 = 0x18
	
	@usableFromInline let rawValue: UInt16
	
	@usableFromInline init(_ rawValue: UInt16) {
		self.rawValue = rawValue
	}
	
	//MARK: Computed Properties
	
	@usableFromInline var code: UInt8? {
		switch self {
		case .disabled: return 23
		case .enabled: return 3
		default: return fallback
		}
	}
	
}

//MARK: - Console Underline

public struct ConsoleUnderline: _ConsoleDecorationAttribute {
	
	//MARK: Constants
	
	public static let inherited = ConsoleUnderline(0)
	
	public static let none = ConsoleUnderline(0x20)
	public static let single = ConsoleUnderline(0x60)
	
	//MARK: Attribute
	
	@usableFromInline static let mask: UInt16 = 0x60
	
	@usableFromInline let rawValue: UInt16
	
	@usableFromInline init(_ rawValue: UInt16) {
		self.rawValue = rawValue
	}
	
	//MARK: Computed Properties
	
	@usableFromInline var code: UInt8? {
		switch self {
		case .none: return 24
		case .single: return 4
		default: return fallback
		}
	}
	
}

//MARK: - Console Blink

public struct ConsoleBlink: _ConsoleDecorationAttribute {
	
	//MARK: Constants
	
	public static let inherited = ConsoleBlink(0)
	
	public static let steady = ConsoleBlink(0x80)
	public static let slow = ConsoleBlink(0x180)
	public static let fast = ConsoleBlink(0x280)
	
	//MARK: Attribute
	
	@usableFromInline static let mask: UInt16 = 0x380
	
	@usableFromInline let rawValue: UInt16
	
	@inlinable public init(_ rawValue: UInt16) {
		self.rawValue = rawValue
	}
	
	//MARK: Computed Properties
	
	@usableFromInline var code: UInt8? {
		switch self {
		case .steady: return 25
		case .slow: return 5
		case .fast: return 6
		default: return fallback
		}
	}
	
}

//MARK: - Console Inverse

public struct ConsoleInverse: _ConsoleDecorationAttribute {
	
	//MARK: Constants
	
	public static let inherited = ConsoleInverse(0)
	
	public static let disabled = ConsoleInverse(0x400)
	public static let enabled = ConsoleInverse(0xC00)
	
	//MARK: Attribute
	
	@usableFromInline static let mask: UInt16 = 0xC00
	
	@usableFromInline let rawValue: UInt16
	
	@usableFromInline init(_ rawValue: UInt16) {
		self.rawValue = rawValue
	}
	
	//MARK: Computed Properties
	
	@usableFromInline var code: UInt8? {
		switch self {
		case .disabled: return 27
		case .enabled: return 7
		default: return fallback
		}
	}
	
}

//MARK: - Console Visibility

public struct ConsoleVisibility: _ConsoleDecorationAttribute {
	
	//MARK: Constants
	
	public static let inherited = ConsoleVisibility(0)
	
	public static let visible = ConsoleVisibility(0x1000)
	public static let hidden = ConsoleVisibility(0x3000)
	
	//MARK: Attribute
	
	@usableFromInline static let mask: UInt16 = 0x3000
	
	@usableFromInline let rawValue: UInt16
	
	@usableFromInline init(_ rawValue: UInt16) {
		self.rawValue = rawValue
	}
	
	//MARK: Computed Properties
	
	@usableFromInline var code: UInt8? {
		switch self {
		case .visible: return 28
		case .hidden: return 8
		default: return fallback
		}
	}
	
}

//MARK: - Console Strikethrough

public struct ConsoleStrikethrough: _ConsoleDecorationAttribute {
	
	//MARK: Constants
	
	public static let inherited = ConsoleStrikethrough(0)
	
	public static let disabled = ConsoleStrikethrough(0x4000)
	public static let enabled = ConsoleStrikethrough(0xC000)
	
	//MARK: Attribute
	
	@usableFromInline static let mask: UInt16 = 0xC000
	
	@usableFromInline let rawValue: UInt16
	
	@usableFromInline init(_ rawValue: UInt16) {
		self.rawValue = rawValue
	}
	
	//MARK: Computed Properties
	
	@usableFromInline var code: UInt8? {
		switch self {
		case .disabled: return 28
		case .enabled: return 9
		default: return fallback
		}
	}
	
}
