import Foundation

extension Interpreter {
    
    //MARK: Default Commands
    
    public static let gBase = CommandGroup("", cExit, cHelp)
    
    public static let cExit = Command("exit", "") { exit(EXIT_SUCCESS) }
    public static let cHelp = Command("help", "", Interpreter.help)
    
}
