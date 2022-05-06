//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-03-11.
//

//MARK: - Control Code

enum ControlCode {
	
	static let ESC: Character = "\u{001B}"
	static let CSI = "\(ESC)["
	
	static let foreground: UInt8 = 38
	static let background: UInt8 = 48
	
	static let bit8: UInt8 = 5
	static let bit24: UInt8 = 2
}
