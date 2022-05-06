//
//  File.swift
//  
//
//  Created by Christophe Bronner on 11/06/2020.
//

import Foundation
import Termios

//MARK: - Terminal

public struct Terminal {
    
    //MARK: Configuration
    
    /// Set to false to prevent styling, for use in Xcode's console for example.
	public static var isStyleEnabled = ProcessInfo.processInfo.environment["XCODE"] == nil // TODO: Move style flags to Style, such as Style.enabled
	
	/// The terminal's current configuration
	@inlinable public static var configuration: Termios {
		get { .current }
		set { newValue.apply() }
	}
	
	/// Executes a block with a specific configuration, then returns to the previous configuration
	@inlinable public static func with<T>(configuration mode: Termios, do block: () -> T) -> T {
		let backup = Termios.current
		mode.apply()
		let tmp = block()
		backup.apply()
		return tmp
	}
    
	//MARK: OLD ECHO MODE
	
    private static var _isEchoEnabled = true
	
	private static var mode = termios()
    
    /// Wether the Terminal is echo-ing stdin to stdout. True by default.
    public static var isEchoEnabled: Bool {
        get { _isEchoEnabled }
        set {
			guard newValue != isEchoEnabled else { return }
			(newValue ? restoreTerminalMode : nonEchoingMode)()
			_isEchoEnabled = newValue
        }
    }
    
    /// Inside the closure, user is allowed to input
    ///
    /// - Parameter f: The closure to execute while in Echo mode
    @discardableResult public static func withEcho<T>(_ f: () -> T) -> T {
        let tmp = isEchoEnabled
        isEchoEnabled = true
        let ret = f()
        isEchoEnabled = tmp
        return ret
    }
    
    /// Inside the closure, user isn't allowed to input
    ///
    /// - Parameter f: The closure to execute while not in Echo mode
    @discardableResult public static func withoutEcho<T>(_ f: () -> T) -> T {
        let tmp = isEchoEnabled
        isEchoEnabled = false
        let ret = f()
        isEchoEnabled = tmp
        return ret
    }
	
	/// Non-echoing terminal mode
    private static func nonEchoingMode() {
		updateTerminalMode { terminal in
			// Disable CANONical mode and ECHO-ing input
			terminal.c_lflag &= ~TermiosFlags(ICANON | ECHO)
			// Acknowledge CRNL line ending and UTF8 input
			terminal.c_iflag &= ~TermiosFlags(ICRNL | IUTF8)
		}
	}
	
	/// Full raw mode, no input processing at all
	private static func rawMode() {
		updateTerminalMode { terminal in
			cfmakeraw(&terminal)
		}
	}
	
	//MARK: Utilities
	
	private static func restoreTerminalMode() {
		restore(into: &mode)
	}
	
	private static func restore(into mode: inout termios) {
		tcsetattr(STDIN_FILENO, TCSANOW, &mode)
	}
	
	private static func updateTerminalMode(transform: (inout termios) -> Void) {
		// Fetch current terminal mode
		tcgetattr(STDIN_FILENO, &mode)
		atexit { Terminal.restoreTerminalMode() }
		
		// Configure the new mode
		var tmp = mode
		transform(&tmp)
		
		// Enable the new mode
		tcsetattr(STDIN_FILENO, TCSANOW, &tmp)
	}
	
}
