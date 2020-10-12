//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

//MARK: - Command Group

public struct Group {
	
	//MARK: Properties
	
	internal let name: String
	internal let summary: String?
	internal private(set) var commands: [Command] = []
	
	//MARK: Initialization
	
	public init(_ name: String, description: String = "") {
		self.name = name
		
		let tmp = sanitize(description)
		summary = tmp.isEmpty ? nil : tmp
	}
	
	//MARK: Methods
	
	public func with(command: Command) -> Group {
		var tmp = self
		tmp.add(command: command)
		return tmp
	}
	
	internal func command(for keyword: String) -> Command? {
		commands.first { $0.is(keyword) }
	}
	
	//MARK: Operators
	
	public static func +=(lhs: inout Group, rhs: Command) {
		lhs.add(command: rhs)
	}
	
	//MARK: Utilities
	
	private mutating func add(command: Command) {
		assert(!commands.contains(command), "Cannot have duplicate commands in Group")
		commands.append(command)
	}
	
}
