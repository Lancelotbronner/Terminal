//
//  File.swift
//  
//
//  Created by Christophe Bronner on 10/06/2020.
//

extension String {
    
    //MARK: Print
	
	/// Prints the string to the terminal
    public func print() {
        Swift.print(self, terminator: "")
    }
    
	/// Prints the string and a newline character to the terminal
    public func println() {
        Swift.print(self)
    }
	
	//MARK: Output
	
	/// Prints the string to the terminal using `Output`
	public func output() {
		Output.write(self)
	}
	
	/// Prints the string and a newline character to the terminal using `Output`
	public func outputln() {
		Output.writeln(self)
	}
    
}
