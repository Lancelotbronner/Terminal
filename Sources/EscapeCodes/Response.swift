//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-04-24.
//

//MARK: - Control Responses

public struct ControlResponse {
	
	/// Parses a cursor position response
	public static func DSR(_ response: String) -> (row: Int, column: Int) {
		var i = response.startIndex
		
		while response[i] != "[" {
			i = response.index(after: i)
		}
		
		let startOfRow = i
		while response[i] != ";" {
			i = response.index(after: i)
		}
		let row = Int(response[startOfRow...i]) ?? 0
		
		i = response.index(after: i)
		
		let startOfColumn = i
		while response[i] != "R" {
			i = response.index(after: i)
		}
		let column = Int(response[startOfColumn...i]) ?? 0
		
		return (row, column)
	}
	
}
