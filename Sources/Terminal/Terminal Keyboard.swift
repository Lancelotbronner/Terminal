import Darwin

extension Terminal {
    
    //MARK: - Key Codes
    
    public enum FlowKey: Character {
        case none = "\u{00}" // \0 NUL
        case bell = "\u{07}" // \a BELL
        case erase = "\u{08}" // BS
        case tab = "\u{09}" // \t TAB (horizontal)
        case linefeed = "\u{0A}" // \n LF
        case vtab = "\u{0B}" // \v VT (vertical tab)
        case formfeed = "\u{0C}" // \f FF
        case enter = "\u{0D}" // \r CR
        case eol = "\u{1A}" // SUB or EOL
        case esc = "\u{1B}" // \e ESC
        case space = "\u{20}" // SPACE
        case del = "\u{7F}" // DEL
        
        var char: Character { rawValue }
        var code: UInt8 { rawValue.asciiValue! }
    }
    
    public enum Key: UInt8 {
        case none = 0 // null
        
        case up = 65 // ESC [ A
        case down = 66 // ESC [ B
        case right = 67 // ESC [ C
        case left = 68 // ESC [ D
        
        case end = 70 // ESC [ F or ESC [ 4~
        case home = 72 // ESC [ H or ESC [ 1~
        case insert = 2 // ESC [ 2~
        case delete = 3 // ESC [ 3~
        case pageUp = 5 // ESC [ 5~
        case pageDown = 6 // ESC [ 6~
        
        case f1 = 80 // ESC O P or ESC [ 11~
        case f2 = 81 // ESC O Q or ESC [ 12~
        case f3 = 82 // ESC O R or ESC [ 13~
        case f4 = 83 // ESC O S or ESC [ 14~
        case f5 = 15 // ESC [ 15~
        case f6 = 17 // ESC [ 17~
        case f7 = 18 // ESC [ 18~
        case f8 = 19 // ESC [ 19~
        case f9 = 20 // ESC [ 20~
        case f10 = 21 // ESC [ 21~
        case f11 = 23 // ESC [ 23~
        case f12 = 24 // ESC [ 24~
        
        init(CSINumber key: UInt8) {
            switch key {
            case 1: self = .home
            case 2: self = .insert
            case 3: self = .delete
            case 4: self = .end
            case 5: self = .pageUp
            case 6: self = .pageDown
            case 11: self = .f1
            case 12: self = .f2
            case 13: self = .f3
            case 14: self = .f4
            case 15: self = .f5
            case 17: self = .f6
            case 18: self = .f7
            case 19: self = .f8
            case 20: self = .f9
            case 21: self = .f10
            case 23: self = .f11
            case 24: self = .f12
            default: self = .none
            }
        }
        
        init(CSILetter key: UInt8) {
            switch key {
            case 65: self = .up
            case 66: self = .down
            case 67: self = .left
            case 68: self = .right
            case 72: self = .home
            case 70: self = .end
            case 80: self = .f1
            case 81: self = .f2
            case 82: self = .f3
            case 83: self = .f4
            default: self = .none
            }
        }
        
        init(SS3Letter key: UInt8) {
            switch key {
              case 80: self = .f1
              case 81: self = .f2
              case 82: self = .f3
              case 83: self = .f4
              default: self = .none
            }
        }
    }
    
    public enum MetaKey: UInt8 {
        case control = 1
        case shift = 2
        case alt = 3
        
        static func CSIMeta(_ key: UInt8) -> [MetaKey] {
            switch key {
            case  2: return [.shift]                     // ESC [ x ; 2~
            case  3: return [.alt]                       // ESC [ x ; 3~
            case  4: return [.shift, .alt]               // ESC [ x ; 4~
            case  5: return [.control]                   // ESC [ x ; 5~
            case  6: return [.shift, .control]           // ESC [ x ; 6~
            case  7: return [.alt, .control]           // ESC [ x ; 7~
            case  8: return [.shift, .alt, .control]   // ESC [ x ; 8~
            default: return []
            }
        }
    }
    
    //MARK: - Predicates
    
    static func isLetter(_ key: Int) -> Bool {
        65...90 ~= key
    }
    
    static func isNumber(_ key: Int) -> Bool {
        48...57 ~= key
    }
    
    static func isLetter(_ str: String) -> Bool {
        "A"..."Z" ~= str
    }
    
    static func isNumber(_ str: String) -> Bool {
        "0"..."9" ~= str
    }
    
    //MARK: - Input Assess
    
    static var isKeyPressed: Bool {
        if !isNonBlocking { enableNonBlocking() }
        var fds = [pollfd(fd: STDIN_FILENO, events: Int16(POLLIN), revents: 0)]
        return poll(&fds, 1, 0) > 0
    }
    
    public static func readKey() -> (code: Key, meta: [MetaKey]) {
        nonBlocking {
            var code = Key.none
            var meta: [MetaKey] = []
            
            // make sure there is data in stdin
            guard isKeyPressed else { return (code, meta) }
            
            var val: Int = 0
            var key: Int = 0
            var cmd: String = ESC
            var chr: Character
            
            loop: while true {
                cmd.append(read())  // check for ESC combination
                switch cmd {
                case CSI:
                    key = readCode()
                    
                    switch true {
                    case isLetter(key):
                        code = Key(CSILetter: UInt8(key))
                        break loop
                        
                    case isNumber(key):
                        cmd = String(unicode(key)) // collect numbers
                        
                        chr = read()
                        while chr.isNumber {
                            cmd.append(chr)
                            chr = read()  // char after number has been read
                        }
                        
                        val = Int(cmd)!  // guaranted valid number
                        
                        guard chr == ";" else {
                            code = Key(CSINumber: UInt8(val))
                            break loop
                        }
                        
                        cmd = String(read()) // CSI + numbers + ; + meta
                        if isNumber(cmd) { meta = MetaKey.CSIMeta(UInt8(cmd)!) }
                        
                        if val == 1 {  // CSI + 1 + ; + meta
                            key = readCode() // CSI + 1 + ; + meta + letter
                            if isLetter(key) { code = Key(CSILetter: UInt8(key)) }
                            break loop
                        }
                        else {// CSI + numbers + ; + meta + ~
                            code = Key(CSINumber: UInt8(val))
                            _ = readCode()  // dismiss the tilde (guaranted)
                            break loop
                        }
                        
                    default:
                        break loop
                    }
                    
                case SS3:
                    key = readCode()
                    if isLetter(key) {
                        code = Key(SS3Letter: UInt8(key))
                    }
                    break loop
                    
                default:
                    break loop
                }
            }
            
            return (code, meta)
        }
    }
    
}
