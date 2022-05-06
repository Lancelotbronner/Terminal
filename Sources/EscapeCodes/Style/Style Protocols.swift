//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-04-24.
//

//MARK: - Console Style Attribute

public protocol ConsoleStyleAttribute: Hashable, CustomStringConvertible {
	
	static var inherited: Self { get }
	
	init(_ rawValue: UInt16)
	
	var rawValue: UInt16 { get }
	
}

extension ConsoleStyleAttribute {
	
	//MARK: Computed Properties
	
	@inlinable public var isInherited: Bool {
		self == .inherited
	}
	
	@inlinable public var isConfigured: Bool {
		!isInherited
	}
	
	//MARK: Methods
	
	@usableFromInline func fallback(describe attribute: Self) -> String {
		switch attribute.rawValue {
		case 0: return "inherited"
		default:
			assertionFailure("Unknown \(Self.self) with raw value \(attribute.rawValue)")
			return ""
		}
	}
	
	@usableFromInline func fallback(sequence attribute: Self) -> UInt8? {
		switch attribute.rawValue {
		case 0: return nil
		default:
			assertionFailure("Unknown \(Self.self) with raw value \(attribute.rawValue)")
			return nil
		}
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

