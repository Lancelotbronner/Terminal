//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

extension Call {
	public struct Value {
		
		//MARK: Properties
		
		internal let raw: String
		private var cache: Any?
		private var type: ArgumentType.Type?
		
		//MARK: Initialization
		
		internal init(_ raw: String) {
			self.raw = raw
		}
		
		//MARK: Assume
		
		internal mutating func assume(_ type: ArgumentType.Type) throws {
			cache = try type.init(parse: raw)
			self.type = type
		}
		
		@discardableResult
		internal mutating func assume(try type: ArgumentType.Type) -> Bool {
			do { try assume(type) }
			catch { return false }
			return true
		}
		
	}
}
