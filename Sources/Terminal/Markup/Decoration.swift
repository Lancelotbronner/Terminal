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
		get { unpack() }
		set { pack(newValue) }
	}
	
	@inlinable public var underline: ConsoleUnderline {
		get { unpack() }
		set { pack(newValue) }
	}
	
	@inlinable public var italics: ConsoleItalics {
		get { unpack() }
		set { pack(newValue) }
	}
	
	@inlinable public var blink: ConsoleBlink {
		get { unpack() }
		set { pack(newValue) }
	}
	
	@inlinable public var inverse: ConsoleInverse {
		get { unpack() }
		set { pack(newValue) }
	}
	
	@inlinable public var visibility: ConsoleVisibility {
		get { unpack() }
		set { pack(newValue) }
	}
	
	@inlinable public var strikethrough: ConsoleStrikethrough {
		get { unpack() }
		set { pack(newValue) }
	}
	
	@inlinable public var description: String {
		var tmp: [UInt8] = []
		tmp.reserveCapacity(ConsoleDecoration.MAX_ATTRIBUTES)
		build(sequence: &tmp)
		return ControlSequence.SGR(tmp)
	}
	
	//MARK: Initialization
	
	@inlinable public init(
		weight: ConsoleWeight = .inherited,
		underline: ConsoleUnderline = .inherited,
		italics: ConsoleItalics = .inherited,
		blink: ConsoleBlink = .inherited,
		inverse: ConsoleInverse = .inherited,
		visibility: ConsoleVisibility = .inherited,
		strikethrough: ConsoleStrikethrough = .inherited
	) {
		rawValue = 0
		self.weight = weight
		self.underline = underline
		self.italics = italics
		self.blink = blink
		self.inverse = inverse
		self.visibility = visibility
		self.strikethrough = strikethrough
	}
	
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
	
	//MARK: Utilities
	
	@usableFromInline func unpack<T: _ConsoleDecorationAttribute>() -> T {
		T.init(rawValue & T.mask)
	}
	
	@usableFromInline mutating func pack<T: _ConsoleDecorationAttribute>(_ value: T)  {
		rawValue = (rawValue & ~T.mask) | value.rawValue
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
