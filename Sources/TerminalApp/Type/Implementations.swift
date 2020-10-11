//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

//MARK: - Quick Implementations

extension Int: ArgumentType { }
extension Double: ArgumentType { }

//MARK: - String

extension String: ArgumentType, Error {
	
	public init(parse description: String) throws {
		self = description
		if hasPrefix("\"") && hasSuffix("\"") {
			removeFirst()
			removeLast()
		}
	}
	
}

//MARK: - Bool

extension Bool: ArgumentType {
	
	public init(parse description: String) throws {
		switch description.lowercased() {
		case "true", "yes", "1", "on": self = true
		case "false", "no", "0", "off": self = false
		default: throw "Invalid boolean value '\(description)', try true or false"
		}
	}
	
}
