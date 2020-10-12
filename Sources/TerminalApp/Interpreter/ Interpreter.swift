//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

import Terminal

//MARK: - Interpreter

public struct Interpreter {
	
	//MARK: Properties
	
	public var configuration: Configuration
	
	internal private(set) var defaultGroup: Group?
	internal private(set) var namedGroups: [Group] = []
	
	private lazy var help = generateHelp()
	
	//MARK: Computed Properties
	
	internal var groups: [Group] {
		var list = namedGroups
		if let tmp = defaultGroup {
			list.append(tmp)
		}
		return list
	}
	
	public var isEmpty: Bool {
		namedGroups.isEmpty && defaultGroup == nil
	}
	
	//MARK: Initialization
	
	public init(_ configuration: Configuration = .init()) {
		self.configuration = configuration
	}
	
	//MARK: Interpret
	
	@discardableResult
	public mutating func interpret(_ raw: String) throws -> Bool {
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
		
		try use.execute(using: &call)
		
		return true
	}
	
	public func handle<T>(_ f: () throws -> T) -> T? {
		do { return try f() }
		catch {
			"\(error)"
				.foreground(.red)
				.outputln()
		}
		return nil
	}
	
	//MARK: Manipulation
	
	public mutating func clear() {
		defaultGroup = nil
		namedGroups = []
	}
	
	public mutating func register(_ group: Group) {
		namedGroups.append(group)
	}
	
	public mutating func register(_ command: Command) {
		if defaultGroup == nil {
			defaultGroup = Group("")
		}
		defaultGroup! += command
	}
	
	//MARK: Operators
	
	public static func +=(lhs: inout Interpreter, rhs: Group) {
		lhs.register(rhs)
	}
	
	public static func +=(lhs: inout Interpreter, rhs: Command) {
		lhs.register(rhs)
	}
	
	//MARK: Utilities
	
	private mutating func command(for keyword: String) -> Command? {
		switch keyword {
		case "help": return help
		default: break
		}
		
		for group in groups {
			if let command = group.command(for: keyword) {
				return command
			}
		}
		
		return nil
	}
	
}
