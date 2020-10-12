//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

import Foundation

//MARK: - Usage

public struct Usage: Equatable {
	
	//MARK: Typealiases
	
	public typealias Action = (inout Call) throws -> Void
	public typealias QuickAction = () throws -> Void
	
	//MARK: Properties
	
	internal let summary: String?
	private let action: Action
	internal private(set) var arguments: [Argument]
	
	//MARK: Computed Properties
	
	private var minimumNumberOfRealArguments: Int? {
		var count = 0
		for arg in arguments {
			switch true {
			case arg.isVariadic: return nil
			case arg.isOptional: continue
			default: count += 1
			}
		}
		return count
	}
	
	//MARK: Initialization
	
	internal init(raw desc: String, _ args: [Argument], _ action: @escaping Action) {
		arguments = args
		self.action = action
		
		let tmp = sanitize(desc)
		summary = tmp.isEmpty ? nil : tmp
	}
	
	public init(_ description: String, arguments: Argument..., action: @escaping Action) {
		self.init(raw: description, arguments, action)
	}
	
	public init(_ description: String, action: @escaping QuickAction) {
		self.init(raw: description, []) { _ in try action() }
	}
	
	//MARK: Manipulation
	
	/// Adds an argument to this usage
	///
	/// - Parameters:
	///   - type: The argument's type
	///   - name: The argument's name
	/// - Returns: A new usage with the added argument
	public func with(_ type: Argument.ValueType, name: String = "") -> Usage {
		with(.init(name, type: type))
	}
	
	/// Adds an optional argument to this usage
	///
	/// - Parameters:
	///   - type: The argument's type
	///   - name: The argument's name
	/// - Returns: A new usage with the added argument
	public func with(optional type: Argument.ValueType, name: String = "") -> Usage {
		with(.init(name, optional: type))
	}
	
	/// Adds a variadic argument to this usage
	///
	/// - Parameters:
	///   - type: The argument's type
	///   - name: The argument's name
	/// - Returns: A new usage with the added argument
	public func with(variadic type: Argument.ValueType, name: String = "") -> Usage {
		with(.init(name, variadic: type))
	}
	
	//MARK: Methods
	
	internal func execute(using call: inout Call) throws {
		try action(&call)
	}
	
	internal func verify(using call: inout Call) -> Bool {
		if call.isEmpty && arguments.isEmpty {
			return true
		}
		
		if let min = minimumNumberOfRealArguments, call.args.count < min {
			return false
		}
		
		var i = 0
		for arg in arguments {
			switch true {
			case arg.isOptional:
				guard call.assume(try: arg, for: i) else { continue }
				i += 1
				
			case arg.isVariadic:
				while i < call.args.count {
					guard call.assume(try: arg, for: i) else { return false }
					i += 1
				}
				
			default:
				guard call.assume(try: arg, for: i) else { return false }
				i += 1
			}
		}
		
		return true
	}
	
	//MARK: Operators
	
	public static func +=(lhs: inout Usage, rhs: Argument.ValueType) {
		lhs.add(.init(type: rhs))
	}
	
	public static func +=(lhs: inout Usage, rhs: Argument) {
		lhs.add(rhs)
	}
	
	public static func ==(lhs: Usage, rhs: Usage) -> Bool {
		lhs.arguments == rhs.arguments
	}
	
	//MARK: Utilities
	
	private func with(_ argument: Argument) -> Usage {
		var tmp = self
		tmp.add(argument)
		return tmp
	}
	
	private mutating func add(_ argument: Argument) {
		assert(!(arguments.last?.isVariadic ?? false), "Variadic arguments must appear at the end")
		arguments.append(argument)
	}
	
	internal func assertValidity() {
		var names: Set<String> = []
		for i in 0 ..< arguments.count {
			let arg = arguments[i]
			
			// Check variadic arguments
			if i != arguments.count - 1 {
				assert(!arg.isVariadic, "Variadic arguments should only be at the end of a command")
			}
			
			// Check unique name
			guard let name = arg.name else { continue }
			assert(!names.contains(name), "Argument '\(name)' is used twice, names should be unique")
			names.insert(name)
		}
	}
	
}
