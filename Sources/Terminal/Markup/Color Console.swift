//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-04-24.
//

@usableFromInline enum ConsoleColor: Hashable {
	
	//MARK: Constants
	
	public static let black = ConsoleColor.palette(0)
	public static let red = ConsoleColor.palette(1)
	public static let green = ConsoleColor.palette(2)
	public static let yellow = ConsoleColor.palette(3)
	public static let blue = ConsoleColor.palette(4)
	public static let magenta = ConsoleColor.palette(5)
	public static let cyan = ConsoleColor.palette(6)
	public static let white = ConsoleColor.palette(7)
	
	public static let plain = ConsoleColor.palette(9)
	
	public static let brightBlack = ConsoleColor.palette(60)
	public static let brightRed = ConsoleColor.palette(61)
	public static let brightGreen = ConsoleColor.palette(62)
	public static let brightYellow = ConsoleColor.palette(63)
	public static let brightBlue = ConsoleColor.palette(64)
	public static let brightMagenta = ConsoleColor.palette(65)
	public static let brightCyan = ConsoleColor.palette(66)
	public static let brightWhite = ConsoleColor.palette(67)

	//MARK: Cases

	case inherited
	case palette(UInt8)
	case extended(UInt8)
	case rgb(UInt8, UInt8, UInt8)

	//MARK: Constants

	@usableFromInline static let MAX_ATTRIBUTES = 5
	
	@usableFromInline func build(sequence: inout [UInt8], offset: UInt8) {
		switch self {
		case .inherited: break
		case let .palette(n):
			sequence.append(offset + n)
		case let .extended(i):
			sequence.append(offset + 8)
			sequence.append(5)
			sequence.append(i)
		case let .rgb(r, g, b):
			sequence.append(offset + 8)
			sequence.append(2)
			sequence.append(r)
			sequence.append(g)
			sequence.append(b)
		}
	}

}
