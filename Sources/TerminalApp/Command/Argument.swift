//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

//MARK: - Argument

public struct Argument: Equatable {
	
	//MARK: Properties
	
	public let name: String?
	public let type: ArgumentType.Type
	private let wrap: Wrapping
	
	//MARK: Computed Properties
	
	public var isOptional: Bool { wrap == .optional }
	public var isVariadic: Bool { wrap == .variadic }
	
	//MARK: Initialization
	
	private init(_ name: String, _ type: ValueType, _ wrap: Wrapping) {
		let tmp = sanitize(name)
		self.name = tmp.isEmpty ? nil : tmp
		
		self.type = type.metatype
		self.wrap = wrap
	}
	
	public init(_ name: String = "", type: ValueType) {
		self.init(name, type, .none)
	}
	
	public init(_ name: String = "", optional type: ValueType) {
		self.init(name, type, .optional)
	}
	
	public init(_ name: String = "", variadic type: ValueType) {
		self.init(name, type, .variadic)
	}
	
	//MARK: Operators
	
	public static func ==(lhs: Argument, rhs: Argument) -> Bool {
		lhs.type == rhs.type
	}
	
}

//MARK: Wrapping

extension Argument {
	private enum Wrapping {
		case none
		case optional
		case variadic
	}
}
