import Darwin

public final class Terminal {
    private init() { }
    
    //MARK: - Constants
    
    public static let ESC = "\u{1B}"    // Escape character (27 or 1B)
    public static let SS2 = ESC + "N"   // Single Shift Select of G2 charset
    public static let SS3 = ESC + "O"   // Single Shift Select of G3 charset
    public static let DCS = ESC + "P"   // Device Control String
    public static let CSI = ESC + "["   // Control Sequence Introducer
    public static let OSC = ESC + "]"   // Operating System Command
    
    //MARK: - Properties
    
    public internal(set) static var isNonBlocking = false
    public internal(set) static var isCursorVisible = true
    public internal(set) static var isReplacing = false
    
    private(set) static var term = termios()
    
    //MARK: - Non-Blocking
    
    public static func nonBlocking<T>(_ f: () -> T) -> T {
        let needsSetup = !isNonBlocking
        if needsSetup { enableNonBlocking() }
        let tmp = f()
        if needsSetup { disableNonBlocking() }
        return tmp
    }
    
    public static func disableNonBlocking() {
        // restore default terminal mode
        tcsetattr(STDIN_FILENO, TCSANOW, &term)
        isNonBlocking = false
    }
    
    public static func enableNonBlocking(rawMode: Bool = false) {
        // store current terminal mode
        tcgetattr(STDIN_FILENO, &term)
        atexit { Terminal.disableNonBlocking() }
        isNonBlocking = true
        
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
    
    //MARK: - Timing
    
    public static func halt() {
        while true { _ = readln() }
    }
    
    @inlinable
    public static func delay(_ ms: Int) {
        usleep(UInt32(ms * 1000))  // convert to seconds
    }
    
    //MARK: - Requests
    
    static func csi(_ codes: CustomStringConvertible...) {
        let str = codes.map { $0.description }.joined(separator: ";")
        std(CSI, str)
    }
    
    // request terminal info using ansi esc command and return the response value
    static func request(_ cmd: String, _ arg: String, _ until: Character) -> String {
        let full = cmd + arg
        return nonBlocking {
            // send request
            Darwin.write(STDOUT_FILENO, full, full.count)
            
            // read response
            var response = ""
            var key: UInt8  = 0
            repeat {
                Darwin.read(STDIN_FILENO, &key, 1)
                response.append(key < 32 ? "^" : char(key))
            } while key != until.asciiValue
            
            return response
        }
    }
    
    //MARK: - Utilities
    
    @inlinable
    static func unicode(_ code: Int) -> Unicode.Scalar {
        Unicode.Scalar(code) ?? "\0"
    }
    
    @inlinable
    static func char(_ code: UInt8) -> Character {
        Character(UnicodeScalar(code))
    }
    
}
