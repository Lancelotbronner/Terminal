//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2020-10-11.
//

import TerminalApp

//MARK: - Program

struct Program: App {
	
	//MARK: Properties
	
	var sourceOfTruth = Bool.random()
	
	func start() {
		container.push(Root())
	}
	
}
