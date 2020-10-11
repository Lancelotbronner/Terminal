//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

//MARK: - Interpreter

public struct Interpreter<SourceOfTruth> {
	
	//MARK: Properties
	
	public var configuration: Configuration
	
	private var defaultGroup: Group<SourceOfTruth>?
	private var groups: [Group<SourceOfTruth>] = []
	
	//MARK: Computed Properties
	
	public var isEmpty: Bool {
		groups.isEmpty && defaultGroup == nil
	}
	
	//MARK: Initialization
	
	public init(_ configuration: Configuration = .init()) {
		self.configuration = configuration
	}
	
	//MARK: Interpret
	
	@discardableResult
	public func interpret(_ raw: String, on owner: inout SourceOfTruth) throws -> Bool {
		let components = raw
			.split(separator: " ", maxSplits: 1)
			.map(String.init)
		guard let keyword = components.first else { return false }
		
		guard let cmd = command(for: keyword) else {
			configuration.handleNoCommandsFound(keyword: raw)
			return false
		}
		
		let content = components.count > 1
			? components.last ?? ""
			: ""
		var call = Call(content, parser: configuration.parser)
		
		guard let use = cmd.usage(for: &call) else {
			configuration.handleWrongUsage(command: cmd)
			return false
		}
		
		try use.execute(using: &call, on: &owner)
		
		return true
	}
	
	//MARK: Manipulation
	
	public mutating func clear() {
		defaultGroup = nil
		groups = []
	}
	
	public mutating func register(_ group: Group<SourceOfTruth>) {
		groups.append(group)
	}
	
	public mutating func register(_ command: Command<SourceOfTruth>) {
		if defaultGroup == nil {
			defaultGroup = Group("")
		}
		defaultGroup! += command
	}
	
	//MARK: Operators
	
	public static func +=(lhs: inout Interpreter, rhs: Group<SourceOfTruth>) {
		lhs.register(rhs)
	}
	
	public static func +=(lhs: inout Interpreter, rhs: Command<SourceOfTruth>) {
		lhs.register(rhs)
	}
	
	//MARK: Utilities
	
	private func command(for keyword: String) -> Command<SourceOfTruth>? {
		switch keyword {
		case "help": return nil // TODO: Return help command
		default: break
		}
		
		for group in groups {
			if let command = group.command(for: keyword) {
				return command
			}
		}
		
		if let command = defaultGroup?.command(for: keyword) {
			return command
		}
		
		return nil
	}
	
}
