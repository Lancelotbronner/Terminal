//
//  File.swift
//  
//
//  Created by Christophe Bronner on 2021-12-26.
//

import Darwin.POSIX.termios

extension Termios {
	
	/// Preset configuration with pure I/O
	@inlinable public static var raw: Termios {
		var tmp = termios()
		cfmakeraw(&tmp)
		return Termios(tmp)
	}
	
	// TODO: Canonical (line-based)
	
	// TODO: Streamed (character-based)
	
}
