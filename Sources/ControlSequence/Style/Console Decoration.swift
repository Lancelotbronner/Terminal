//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-04-24.
//

//MARK: - Console Weight

public struct ConsoleWeight: ConsoleStyleAttribute {
	
	//MARK: Constants
	
	public static let inherited = ConsoleWeight(0)
	
	public static let regular = ConsoleWeight(0x1)
	public static let bold = ConsoleWeight(0x3)
	public static let dim = ConsoleWeight(0x5)
	
	//MARK: Properties
	
	public let rawValue: UInt16
	
	//MARK: Computed Properties
	
	@inlinable public var description: String {
		switch self {
		case .regular: return "regular"
		case .bold: return "bold"
		case .dim: return "dim"
		default: return fallback(describe: self)
		}
	}
	
	@usableFromInline var code: UInt8? {
		switch self {
		case .regular: return 22
		case .bold: return 1
		case .dim: return 2
		default: return fallback(sequence: self)
		}
	}
	
	//MARK: Initialization
	
	@inlinable public init(_ rawValue: UInt16) {
		self.rawValue = rawValue & 0x7
	}
	
}

//MARK: - Console Italics

public struct ConsoleItalics: ConsoleStyleAttribute {
	
	//MARK: Constants
	
	public static let inherited = ConsoleItalics(0)
	
	public static let disabled = ConsoleItalics(0x8)
	public static let enabled = ConsoleItalics(0x18)
	
	//MARK: Properties
	
	public let rawValue: UInt16
	
	//MARK: Computed Properties
	
	@inlinable public var description: String {
		switch self {
		case .disabled: return "disabled"
		case .enabled: return "enabled"
		default: return fallback(describe: self)
		}
	}
	
	@usableFromInline var code: UInt8? {
		switch self {
		case .disabled: return 23
		case .enabled: return 3
		default: return fallback(sequence: self)
		}
	}
	
	//MARK: Initialization
	
	@inlinable public init(_ rawValue: UInt16) {
		self.rawValue = rawValue & 0x18
	}
	
}

//MARK: - Console Underline

public struct ConsoleUnderline: ConsoleStyleAttribute {
	
	//MARK: Constants
	
	public static let inherited = ConsoleUnderline(0)
	
	public static let none = ConsoleUnderline(0x20)
	public static let single = ConsoleUnderline(0x60)
	
	//MARK: Properties
	
	public let rawValue: UInt16
	
	//MARK: Computed Properties
	
	@inlinable public var description: String {
		switch self {
		case .none: return "none"
		case .single: return "single"
		default: return fallback(describe: self)
		}
	}
	
	@usableFromInline var code: UInt8? {
		switch self {
		case .none: return 24
		case .single: return 4
		default: return fallback(sequence: self)
		}
	}
	
	//MARK: Initialization
	
	@inlinable public init(_ rawValue: UInt16) {
		self.rawValue = rawValue & 0x60
	}
	
}

//MARK: - Console Blink

public struct ConsoleBlink: ConsoleStyleAttribute {
	
	//MARK: Constants
	
	public static let inherited = ConsoleBlink(0)
	
	public static let steady = ConsoleBlink(0x80)
	public static let slow = ConsoleBlink(0x180)
	public static let fast = ConsoleBlink(0x280)
	
	//MARK: Properties
	
	public let rawValue: UInt16
	
	//MARK: Computed Properties
	
	@inlinable public var description: String {
		switch self {
		case .steady: return "steady"
		case .slow: return "slow"
		case .fast: return "fast"
		default: return fallback(describe: self)
		}
	}
	
	@usableFromInline var code: UInt8? {
		switch self {
		case .steady: return 25
		case .slow: return 5
		case .fast: return 6
		default: return fallback(sequence: self)
		}
	}
	
	//MARK: Initialization
	
	@inlinable public init(_ rawValue: UInt16) {
		self.rawValue = rawValue & 0x380
	}
	
}

//MARK: - Console Inverse

public struct ConsoleInverse: ConsoleStyleAttribute {
	
	//MARK: Constants
	
	public static let inherited = ConsoleInverse(0)
	
	public static let disabled = ConsoleInverse(0x400)
	public static let enabled = ConsoleInverse(0xC00)
	
	//MARK: Properties
	
	public let rawValue: UInt16
	
	//MARK: Computed Properties
	
	@inlinable public var description: String {
		switch self {
		case .disabled: return "disabled"
		case .enabled: return "enabled"
		default: return fallback(describe: self)
		}
	}
	
	@usableFromInline var code: UInt8? {
		switch self {
		case .disabled: return 27
		case .enabled: return 7
		default: return fallback(sequence: self)
		}
	}
	
	//MARK: Initialization
	
	@inlinable public init(_ rawValue: UInt16) {
		self.rawValue = rawValue & 0xC00
	}
	
}

//MARK: - Console Visibility

public struct ConsoleVisibility: ConsoleStyleAttribute {
	
	//MARK: Constants
	
	public static let inherited = ConsoleVisibility(0)
	
	public static let visible = ConsoleVisibility(0x1000)
	public static let hidden = ConsoleVisibility(0x3000)
	
	//MARK: Properties
	
	public let rawValue: UInt16
	
	//MARK: Computed Properties
	
	@inlinable public var description: String {
		switch self {
		case .visible: return "visible"
		case .hidden: return "hidden"
		default: return fallback(describe: self)
		}
	}
	
	@usableFromInline var code: UInt8? {
		switch self {
		case .visible: return 28
		case .hidden: return 8
		default: return fallback(sequence: self)
		}
	}
	
	//MARK: Initialization
	
	@inlinable public init(_ rawValue: UInt16) {
		self.rawValue = rawValue & 0x3000
	}
	
}

//MARK: - Console Strikethrough

public struct ConsoleStrikethrough: ConsoleStyleAttribute {
	
	//MARK: Constants
	
	public static let inherited = ConsoleStrikethrough(0)
	
	public static let disabled = ConsoleStrikethrough(0x4000)
	public static let enabled = ConsoleStrikethrough(0xC000)
	
	//MARK: Properties
	
	public let rawValue: UInt16
	
	//MARK: Initialization
	
	@inlinable public init(_ rawValue: UInt16) {
		self.rawValue = rawValue & 0xC000
	}
	
	//MARK: Computed Properties
	
	@inlinable public var description: String {
		switch self {
		case .disabled: return "disabled"
		case .enabled: return "enabled"
		default: return fallback(describe: self)
		}
	}
	
	@usableFromInline var code: UInt8? {
		switch self {
		case .disabled: return 28
		case .enabled: return 9
		default: return fallback(sequence: self)
		}
	}
	
}

//MARK: - Console Decoration

public struct ConsoleDecoration: Hashable {
	
	//MARK: Constants
	
	@usableFromInline static let MAX_ATTRIBUTES = 7
	
	public static let inherited = ConsoleDecoration(0)
	
	public static let regular: ConsoleDecoration = {
		var tmp = ConsoleDecoration.inherited
		tmp.weight = .regular
		tmp.underline = .none
		tmp.italics = .disabled
		tmp.blink = .steady
		tmp.inverse = .disabled
		tmp.visibility = .visible
		tmp.strikethrough = .disabled
		return tmp
	}()
	
	//MARK: Properties
	
	public var rawValue: UInt16
	
	//MARK: Computed Properties
	
	@inlinable public var weight: ConsoleWeight {
		get { .init(rawValue) }
		set { rawValue |= newValue.rawValue }
	}
	
	@inlinable public var underline: ConsoleUnderline {
		get { .init(rawValue) }
		set { rawValue |= newValue.rawValue }
	}
	
	@inlinable public var italics: ConsoleItalics {
		get { .init(rawValue) }
		set { rawValue |= newValue.rawValue }
	}
	
	@inlinable public var blink: ConsoleBlink {
		get { .init(rawValue) }
		set { rawValue |= newValue.rawValue }
	}
	
	@inlinable public var inverse: ConsoleInverse {
		get { .init(rawValue) }
		set { rawValue |= newValue.rawValue }
	}
	
	@inlinable public var visibility: ConsoleVisibility {
		get { .init(rawValue) }
		set { rawValue |= newValue.rawValue }
	}
	
	@inlinable public var strikethrough: ConsoleStrikethrough {
		get { .init(rawValue) }
		set { rawValue |= newValue.rawValue }
	}
	
	@usableFromInline var sequence: [UInt8] {
		var tmp: [UInt8] = []
		tmp.reserveCapacity(ConsoleDecoration.MAX_ATTRIBUTES)
		build(sequence: &tmp)
		return tmp
	}
	
	//MARK: Initialization
	
	@usableFromInline init(_ rawValue: UInt16) {
		self.rawValue = rawValue
	}
	
	//MARK: Methods
	
	@usableFromInline func build(sequence: inout [UInt8]) {
		func append(_ code: UInt8?) {
			guard let code = code else { return }
			sequence.append(code)
		}
		
		append(weight.code)
		append(underline.code)
		append(italics.code)
		append(blink.code)
		append(inverse.code)
		append(visibility.code)
		append(strikethrough.code)
	}
	
	//MARK: Operators
	
	@inlinable public static func & (lhs: ConsoleDecoration, rhs: ConsoleDecoration) -> ConsoleDecoration {
		var tmp = lhs
		tmp &= rhs
		return tmp
	}
	
	@inlinable public static func &= (lhs: inout ConsoleDecoration, rhs: ConsoleDecoration) {
		lhs.weight |= rhs.weight
		lhs.underline |= rhs.underline
		lhs.italics |= rhs.italics
		lhs.blink |= rhs.blink
		lhs.inverse |= rhs.inverse
		lhs.visibility |= rhs.visibility
		lhs.strikethrough |= rhs.strikethrough
	}
	
	@inlinable public static func | (lhs: Self, rhs: Self) -> Self {
		var tmp = lhs
		tmp |= rhs
		return tmp
	}
	
	@inlinable public static func |= (lhs: inout ConsoleDecoration, rhs: ConsoleDecoration) {
		lhs.weight &= rhs.weight
		lhs.underline &= rhs.underline
		lhs.italics &= rhs.italics
		lhs.blink &= rhs.blink
		lhs.inverse &= rhs.inverse
		lhs.visibility &= rhs.visibility
		lhs.strikethrough &= rhs.strikethrough
	}
	
	@inlinable public static func ^ (lhs: Self, rhs: Self) -> Self {
		var tmp = lhs
		tmp ^= rhs
		return tmp
	}
	
	@inlinable public static func ^= (lhs: inout ConsoleDecoration, rhs: ConsoleDecoration) {
		lhs.weight ^= rhs.weight
		lhs.underline ^= rhs.underline
		lhs.italics ^= rhs.italics
		lhs.blink ^= rhs.blink
		lhs.inverse ^= rhs.inverse
		lhs.visibility ^= rhs.visibility
		lhs.strikethrough ^= rhs.strikethrough
	}
		
}
