//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

import Foundation

//MARK: Utilities

public func sanitize(_ string: String) -> String {
	string
		.components(separatedBy: CharacterSet.illegalCharacters.union(.newlines))
		.joined()
		.trimmingCharacters(in: .whitespaces)
}

//MARK: Container

fileprivate var _container: Any?

@inline(__always)
internal func container<T>(set container: Container<T>) {
	_container = container
}

@inline(__always)
internal func container<T>() -> Container<T> {
	_container as! Container<T>
}
