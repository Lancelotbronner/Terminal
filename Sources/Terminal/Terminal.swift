//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-03-11.
//

import Termios
@_exported import Ansi

//MARK: - Terminal

public struct Terminal {
	
	//MARK: Style
	
	public static var isStyleEnabled: Bool = {
		// TODO: Autocheck wether styling should be enabled
		// - Check wether tty or output
		// - Check for NO_COLOR env variable
		true
	}()
	
	//MARK: Configuration
	
	/// The terminal's current configuration
	@inlinable public static var configuration: Termios {
		get { .current }
		set { newValue.apply() }
	}
	
	/// Executes a block with a specific configuration, then returns to the previous configuration
	@inlinable public static func with(configuration mode: Termios, do block: () -> Void) {
		let backup = Termios.current
		mode.apply()
		block()
		backup.apply()
	}
	
	/// Executes a block with a specific configuration, then returns to the previous configuration
	@inlinable public static func with(configuration mode: (inout Termios) -> Void, do block: () -> Void) {
		let backup = Termios.current
		var tmp = backup
		mode(&tmp)
		tmp.apply()
		block()
		backup.apply()
	}
	
}
