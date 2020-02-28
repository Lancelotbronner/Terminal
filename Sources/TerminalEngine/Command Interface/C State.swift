
//MARK: - State

public protocol CommandState: CustomDebugStringConvertible {
    var controls: [Commands] { get }
    
    init()
    
    func onEnter()
    func onExit()
}
extension CommandState {
    
    public var debugDescription: String { String(describing: Self.self) }
    
    public func onEnter() { }
    public func onExit() { }
    
}

//MARK: Empty State

struct EmptyCommandState: CommandState {
    var controls: [Commands] = []
    var debugDescription: String { "Empty" }
}
