import Foundation

extension Interpreter {
    
    //MARK: Base Command Group
    
    public static let gBase = CommandGroup("", cExit, cHelp)
    
    public static let cExit = Command("exit", "") { exit(EXIT_SUCCESS) }
    public static let cHelp = Command("help", "", Interpreter.help)
    
    //MARK: - Provided Commands
    
    public static let cBack = Command("back", "") { StateMachine.pop() }
    
}
