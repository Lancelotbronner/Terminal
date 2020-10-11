//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

//MARK: - Command Group

public struct Group<SourceOfTruth> {
	
	//MARK: Properties
	
	private let name: String
	private let summary: String?
	private var commands: [Command<SourceOfTruth>] = []
	
	//MARK: Initialization
	
	public init(_ name: String, description: String = "") {
		self.name = name
		
		let tmp = sanitize(description)
		summary = tmp.isEmpty ? nil : tmp
	}
	
	//MARK: Methods
	
	public func with(command: Command<SourceOfTruth>) -> Group {
		var tmp = self
		tmp.add(command: command)
		return tmp
	}
	
	internal func command(for keyword: String) -> Command<SourceOfTruth>? {
		commands.first { $0.is(keyword) }
	}
	
	//MARK: Operators
	
	public static func +=(lhs: inout Group, rhs: Command<SourceOfTruth>) {
		lhs.add(command: rhs)
	}
	
	//MARK: Utilities
	
	private mutating func add(command: Command<SourceOfTruth>) {
		assert(!commands.contains(command), "Cannot have duplicate commands in Group")
		commands.append(command)
	}
	
}
