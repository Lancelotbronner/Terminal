//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-04-24.
//

//MARK: - Console Color

public enum ConsoleColor: Hashable {
	
	//MARK: Cases
	
	case inherited

	case plain
	
	case black
	case red
	case green
	case yellow
	case blue
	case magenta
	case cyan
	case white
	
	case brightBlack
	case brightRed
	case brightGreen
	case brightYellow
	case brightBlue
	case brightMagenta
	case brightCyan
	case brightWhite
	
	case extended(UInt8)
	case rgb(UInt8, UInt8, UInt8)
	
	//MARK: Constants
	
	@usableFromInline static let MAX_ATTRIBUTES = 5
	
}

//MARK: - Foreground Color

public struct ForegroundColor: Hashable {
	
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
	
	@usableFromInline var sequence: [UInt8] {
		var tmp: [UInt8] = []
		tmp.reserveCapacity(ConsoleColor.MAX_ATTRIBUTES)
		build(sequence: &tmp)
		return tmp
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
		switch color {
		case .inherited: break
		case .plain: sequence.append(39)
		case .black: sequence.append(30)
		case .red: sequence.append(31)
		case .green: sequence.append(32)
		case .yellow: sequence.append(33)
		case .blue: sequence.append(34)
		case .magenta: sequence.append(35)
		case .cyan: sequence.append(36)
		case .white: sequence.append(37)
		case .brightBlack: sequence.append(90)
		case .brightRed: sequence.append(91)
		case .brightGreen: sequence.append(92)
		case .brightYellow: sequence.append(93)
		case .brightBlue: sequence.append(94)
		case .brightMagenta: sequence.append(95)
		case .brightCyan: sequence.append(96)
		case .brightWhite: sequence.append(97)
		case let .extended(id):
			sequence.append(38)
			sequence.append(5)
			sequence.append(id)
		case let .rgb(r, g, b):
			sequence.append(38)
			sequence.append(2)
			sequence.append(r)
			sequence.append(g)
			sequence.append(b)
		}
	}
	
}

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
	
	@usableFromInline var sequence: [UInt8] {
		var tmp: [UInt8] = []
		tmp.reserveCapacity(ConsoleColor.MAX_ATTRIBUTES)
		build(sequence: &tmp)
		return tmp
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
		switch color {
		case .inherited: break
		case .plain: sequence.append(49)
		case .black: sequence.append(40)
		case .red: sequence.append(41)
		case .green: sequence.append(42)
		case .yellow: sequence.append(43)
		case .blue: sequence.append(44)
		case .magenta: sequence.append(45)
		case .cyan: sequence.append(46)
		case .white: sequence.append(47)
		case .brightBlack: sequence.append(100)
		case .brightRed: sequence.append(101)
		case .brightGreen: sequence.append(102)
		case .brightYellow: sequence.append(103)
		case .brightBlue: sequence.append(104)
		case .brightMagenta: sequence.append(105)
		case .brightCyan: sequence.append(106)
		case .brightWhite: sequence.append(107)
		case let .extended(id):
			sequence.append(48)
			sequence.append(5)
			sequence.append(id)
		case let .rgb(r, g, b):
			sequence.append(48)
			sequence.append(2)
			sequence.append(r)
			sequence.append(g)
			sequence.append(b)
		}
	}
	
}
