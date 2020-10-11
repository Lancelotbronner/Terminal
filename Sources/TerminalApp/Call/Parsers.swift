//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

public enum Parsers {
	
	//MARK: - Default Parser
	
	public static var `default`: CommandParser {
		Parser { output, char in
			switch true {
			case char == "\"":
				output.buff(char)
				output.set(to: Parsers.string)
				
			case char.isWhitespace:
				output.commit()
				
			default: output.buff(char)
			}
		}
	}
	
	//MARK: - String Parser
	
	public static var string: CommandParser {
		var escape = false
		return Parser { output, char in
			switch true {
			case escape:
				output.buff(char)
				escape = false
				
			case char == "\\":
				escape = true
				
			case char == "\"":
				output.buff(char)
				output.set(to: Parsers.default)
				
			default: output.buff(char)
			}
		}
	}
	
}
