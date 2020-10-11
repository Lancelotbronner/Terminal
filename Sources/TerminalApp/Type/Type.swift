//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

//MARK: - Type Protocol

public protocol ArgumentType {
	
	init(parse description: String) throws
	
}

extension ArgumentType where Self: LosslessStringConvertible {
	
	public init(parse description: String) throws {
		guard let value = Self.init(description) else { throw "Parsing failed" }
		self = value
	}
	
}
