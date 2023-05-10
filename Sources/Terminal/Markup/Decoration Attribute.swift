//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-04-24.
//

//MARK: - Decoration Attribute

public protocol ConsoleDecorationAttribute: Hashable, CustomStringConvertible {
	
	static var inherited: Self { get }
	
}

extension ConsoleDecorationAttribute {
	
	//MARK: Computed Properties
	
	@inlinable public var isInherited: Bool {
		self == .inherited
	}
	
	@inlinable public var isConfigured: Bool {
		!isInherited
	}
	
	//MARK: Operators
	
	@inlinable public static func & (lhs: Self, rhs: Self) -> Self {
		lhs.isInherited || rhs.isInherited ? .inherited : lhs
	}
	
	@inlinable public static func &= (lhs: inout Self, rhs: Self) {
		lhs = lhs & rhs
	}
	
	@inlinable public static func | (lhs: Self, rhs: Self) -> Self {
		lhs.isInherited ? rhs : lhs
	}
	
	@inlinable public static func |= (lhs: inout Self, rhs: Self) {
		lhs = lhs | rhs
	}
	
	@inlinable public static func ^ (lhs: Self, rhs: Self) -> Self {
		lhs.isConfigured && rhs.isConfigured ? .inherited : (rhs.isConfigured ? rhs : lhs)
	}
	
	@inlinable public static func ^= (lhs: inout Self, rhs: Self) {
		lhs = lhs | rhs
	}
	
}

//MARK: - Console Decoration Attribute

@usableFromInline protocol _ConsoleDecorationAttribute: ConsoleDecorationAttribute {
	
	static var mask: UInt16 { get }
	
	init(_ rawValue: UInt16)
	
	var rawValue: UInt16 { get }
	var code: UInt8? { get }
	
}

extension _ConsoleDecorationAttribute {
	
	//MARK: Computed Properties
	
	@inlinable public var description: String {
		code.map(ControlSequence.SGR(bit8:)) ?? ""
	}
	
	@usableFromInline var fallback: UInt8 {
		switch rawValue {
		case 0: return 0
		default:
			assertionFailure("Unknown \(Self.self) with raw value \(rawValue)")
			return 0
		}
	}
	
}
