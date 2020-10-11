//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

//MARK: - Call

public struct Call {
	
	//MARK: Properties
	
	internal private(set) var args: [Value]
	
	//MARK: Computed Properties
	
	public var isEmpty: Bool { args.isEmpty }
	
	//MARK: Initialization
	
	internal init(_ raw: String, parser: @autoclosure () -> CommandParser = Parsers.default) {
		var parser = parser()
		var output = Output(main: parser)
		
		for char in raw {
			parser.step(&output, char)
		}
		
		args = output.args
	}
	
	//MARK: Assume
	
	internal mutating func assume(_ arg: Argument, for i: Int) throws {
		try args[i].assume(arg.type)
	}
	
	@discardableResult
	internal mutating func assume(try arg: Argument, for i: Int) -> Bool {
		args[i].assume(try: arg.type)
	}
	
	//MARK: Arguments
	
	public mutating func next() throws -> Value {
		.init("")
	}
	
	//MARK: Values
	
	public func string() -> String {
		""
	}
	
	//MARK: Errors
	
	public enum Errors: Error {
		case endOfInput
	}
	
}
