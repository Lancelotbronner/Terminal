//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

import Foundation

//MARK: - Command

public struct Command: Equatable {
	
	//MARK: Properties
	
	internal let summary: String?
	internal let keyword: String
	internal private(set) var alternateKeywords: Set<String> = []
	internal private(set) var uses: [Usage] = []
	
	//MARK: Initialization
	
	private init(internal keyword: String, _ uses: [Usage], _ description: String) {
		self.keyword = keyword
		self.uses = uses
		
		let tmp = sanitize(description)
		summary = tmp.isEmpty ? nil : tmp
	}
	
	/// Creates a command with no arguments
	///
	/// - Parameters:
	///   - keyword: The keyword you can use to call this command, if you need alternate keywords, use `+=` or `with(alt:)`
	///   - description: The command's description
	///   - action: The action executed by that command
	public init(_ keyword: String, description: String, action: @escaping Usage.QuickAction) {
		self.init(internal: keyword, [.init("", action: action)], description)
	}
	
	/// Creates a command requiring the specified arguments
	///
	/// The arguments can be parsed using the call object in the action closure.
	///
	/// - Parameters:
	///   - keyword: The keyword you can use to call this command, if you need alternate keywords, use `+=` or `with(alt:)`
	///   - arguments: The arguments expected by the command
	///   - description: The command's description
	///   - action: The action executed by that command
	public init(_ keyword: String, arguments: Argument..., description: String = "", action: @escaping Usage.Action) {
		self.init(internal: keyword, [.init(raw: "", arguments, action)], description)
	}
	
	/// Creates a grouped command with no actions
	///
	/// To add a usage, you can use `+=` or `with(usage:)`
	///
	/// - Parameters:
	///   - keyword: The keyword you can use to call this command, if you need alternate keywords, use `+=` or `with(alt:)`
	///   - description: The command's description
	public init(_ keyword: String, description: String = "") {
		self.init(internal: keyword, [], description)
	}
	
	//MARK: Manipulation
	
	/// Adds the alternative keyword
	///
	/// - Parameter keyword: The alternate keyword to add
	/// - Returns: A new command with the added keyword
	public func with(alt keyword: String) -> Command {
		var tmp = self
		tmp.add(keyword)
		return tmp
	}
	
	/// Adds another usage
	///
	/// - Parameter usage: The new usage to add
	/// - Returns: A new command with the added keyword
	public func with(usage: Usage) -> Command {
		var tmp = self
		tmp.add(usage)
		return tmp
	}
	
	//MARK: Methods
	
	internal func `is`(_ keyword: String) -> Bool {
		self.keyword == keyword || alternateKeywords.contains(keyword)
	}
	
	internal func usage(for call: inout Call) -> Usage? {
		for usage in uses {
			if usage.verify(using: &call) {
				return usage
			}
		}
		return nil
	}
	
	//MARK: Operators
	
	public static func +=(lhs: inout Command, rhs: String) {
		lhs.add(rhs)
	}
	
	public static func +=(lhs: inout Command, rhs: Usage) {
		lhs.add(rhs)
	}
	
	public static func ==(lhs: Command, rhs: Command) -> Bool {
		!lhs.alternateKeywords.isDisjoint(with: rhs.alternateKeywords)
	}
	
	//MARK: Utilities
	
	private mutating func add(_ keyword: String) {
		assert(!alternateKeywords.contains(keyword) && self.keyword != keyword, "Duplicate keywords aren't allowed")
		alternateKeywords.insert(keyword)
	}
	
	private mutating func add(_ usage: Usage) {
		assert(!self.uses.contains(usage), "Duplicate usage aren't allowed; a usage is the same when same-type arguments are in the same order")
		self.uses.append(usage)
	}
	
	private func assertValidity() {
		for i in 0 ..< uses.count {
			let item = uses[i]
			
			// Verify unique
			let isNotUnique = uses[i ..< uses.count].contains(item)
			assert(!isNotUnique, "Cannot have two usage with the same arguments")
			
			// Sub-verify
			item.assertValidity()
		}
	}
	
}
