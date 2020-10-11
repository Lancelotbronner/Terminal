//
//  File.swift
//  
//
//  Created by Christophe Bronner on 11/06/2020.
//

import Darwin

//MARK: - Terminal

public struct Terminal {
    private init() { }
    
    //MARK: Configuration
    
    /// Set to false to prevent styling, for use in Xcode's console for example.
    public static var isStyleEnabled = true
    
    //MARK: Echo Mode
    
    private static var _isEchoEnabled = true
	private static var term = termios()
    
    /// Wether the Terminal is echo-ing stdin to stdout. True by default.
    public static var isEchoEnabled: Bool {
        get { _isEchoEnabled }
        set {
            if newValue && !isEchoEnabled { enableEcho() }
            if !newValue && _isEchoEnabled { disableEcho() }
            _isEchoEnabled = newValue
        }
    }
    
    /// Inside the closure, user is allowed to input
    ///
    /// - Parameter f: The closure to execute while in Echo mode
    @discardableResult
    public static func withEcho<T>(_ f: () -> T) -> T {
        let tmp = isEchoEnabled
        isEchoEnabled = true
        let ret = f()
        isEchoEnabled = tmp
        return ret
    }
    
    /// Inside the closure, user isn't allowed to input
    ///
    /// - Parameter f: The closure to execute while not in Echo mode
    @discardableResult
    public static func withoutEcho<T>(_ f: () -> T) -> T {
        let tmp = isEchoEnabled
        isEchoEnabled = false
        let ret = f()
        isEchoEnabled = tmp
        return ret
    }
    
    private static func enableEcho() {
        // restore default terminal mode
        tcsetattr(STDIN_FILENO, TCSANOW, &term)
    }
    
    private static func disableEcho(rawMode: Bool = false) {
        // store current terminal mode
        tcgetattr(STDIN_FILENO, &term)
        atexit { Terminal.isEchoEnabled = true }
        
        // configure non-blocking and non-echoing terminal mode
        var nonBlockTerm = term
        if rawMode {
            //! full raw mode without any input processing at all
            cfmakeraw(&nonBlockTerm)
        } else {
            // disable CANONical mode and ECHO-ing input
            nonBlockTerm.c_lflag &= ~tcflag_t(ICANON | ECHO)
            // acknowledge CRNL line ending and UTF8 input
            nonBlockTerm.c_iflag &= ~tcflag_t(ICRNL | IUTF8)
        }
        
        // enable new terminal mode
        tcsetattr(STDIN_FILENO, TCSANOW, &nonBlockTerm)
    }
    
}
