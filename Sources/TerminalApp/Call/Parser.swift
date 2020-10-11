//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

//MARK: - Command Parser

public protocol CommandParser {
	
	init()

	mutating func step(_ output: inout Call.Output, _ char: Character)
	
}

//MARK: - Parser

public struct Parser: CommandParser {
	
	//MARK: Typealiases
	
	public typealias Function = (inout Call.Output, Character) -> Void
	
	//MARK: Properties
	
	private let method: Function
	
	//MARK: Initialization
	
	public init() {
		method = { _, _ in }
	}
	
	public init(_ method: @escaping Function) {
		self.method = method
	}
	
	//MARK: Methods
	
	public func step(_ output: inout Call.Output, _ char: Character) {
		method(&output, char)
	}
	
}

//MARK: - Output

extension Call {
	public struct Output {
		
		//MARK: Properties
		
		public private(set) var buffer = ""
		internal var args: [Value] = []
		private var parser: CommandParser
		
		//MARK: Initialization
		
		internal init(main parser: CommandParser) {
			self.parser = parser
		}
		
		//MARK: Methods
		
		public mutating func buff(_ char: Character) {
			buffer.append(char)
		}
		
		public mutating func clear() {
			buffer = ""
		}
		
		public mutating func commit(_ value: String? = nil) {
			let tmp = sanitize(value ?? buffer)
			if !tmp.isEmpty {
				args.append(.init(tmp))
			}
			buffer = ""
		}
		
		public mutating func set(to parser: CommandParser) {
			self.parser = parser
		}
		
	}
}
