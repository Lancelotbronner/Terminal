//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

extension String {
	
	//MARK: Padding
	
	public func pad(left length: Int, with char: Character = " ") -> String {
		guard count < length else { return self }
		return String(repeating: char, count: length - count) + self
	}
	
	public func pad(right length: Int, with char: Character = " ") -> String {
		guard count < length else { return self }
		return self + String(repeating: char, count: length - count)
	}
	
	//MARK: Inline Manipulation
	
	public func prefixed(with other: String?) -> String {
		guard let other = other else { return self }
		return other + self
	}
	
	public func suffixed(with other: String?) -> String {
		guard let other = other else { return self }
		return appending(other)
	}
	
}
