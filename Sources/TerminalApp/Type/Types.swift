//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

extension Argument {
	public struct ValueType {
		
		//MARK: Constants
		
		public static let string = ValueType(metatype: String.self)
		public static let int = ValueType(metatype: Int.self)
		public static let double = ValueType(metatype: Double.self)
		public static let bool = ValueType(metatype: Bool.self)
		
		//MARK: Properties
		
		internal let metatype: ArgumentType.Type
		
		//MARK: Initialization
		
		public init(metatype: ArgumentType.Type) {
			self.metatype = metatype
		}
		
	}
}
