
//MARK: - State Machine

final class CommandStateMachine {
    
    //MARK: Properties
    
    private var stack: [CommandState] = []
    
    var current: CommandState { stack.last ?? EmptyCommandState() }
    var isEmpty: Bool { stack.isEmpty }
    
    //MARK: Methods
    
    //MARK: Utilities
    
    private func removeLast() {
        guard !isEmpty else { return }
        current.onExit()
        stack.removeLast()
    }
    
}
