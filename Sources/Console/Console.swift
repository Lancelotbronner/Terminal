//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2022-03-11.
//

@_exported import Terminal
@_exported import Prompt

import Termios

//MARK: - Console

public struct Console {
	
	//MARK: Capabilities
	
	public static var isStyleEnabled: Bool = {
		// TODO: Autocheck wether styling should be enabled
		// - Look for XCODE env variable
		// - Check wether tty or output
		// - Check for NO_COLOR env variable
		return true
	}()

	public static var isRequestEnabled: Bool = {
		// TODO: Autocheck wether requests should be enabled
		// - Look for XCODE env variable
		// - Check wether tty or output
		// - Check for NO_COLOR env variable
		return true
	}()
	
	//MARK: Configuration
	
	/// The terminal's current configuration
	@inlinable public static var configuration: Termios {
		get { .current }
		set { newValue.apply() }
	}
	
	/// Executes a block with a specific configuration, then returns to the previous configuration
	@inlinable public static func with(configuration mode: Termios, do block: () -> Void) {
		Termios.with(configuration: mode, do: block)
	}
	
	/// Executes a block with a specific configuration, then returns to the previous configuration
	@inlinable public static func with(configuration mode: (inout Termios) -> Void, do block: () -> Void) {
		Termios.with(configuration: mode, do: block)
	}
	
}
