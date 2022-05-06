//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-03-11.
//

//MARK: - Foreground

//MARK: - Style

public enum Style: UInt8, ModeCode {
	case `default` = 0
	case bold = 1
	case dim = 2
	case italic = 3
	case underline = 4
	case blink = 5
	case swap = 7
	case strikethrough = 9
	
	public var value: [UInt8] {
		return [rawValue]
	}
	
}
