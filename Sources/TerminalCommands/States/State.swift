
//MARK: - State Protocol

public protocol State {
    var controls: [CommandGroup] { get }
    var name: String { get }
    
    func onEnter()
    func shouldExit() -> Bool
    func onExit()
}

extension State {
    
    //MARK: Computed Properties
    
    public var name: String { String(describing: Self.self) }
    public var isEmpty: Bool { controls.isEmpty }
    
    //MARK: Default Implementation
    
    public func onEnter() { }
    public func shouldExit() -> Bool { true }
    public func onExit() { }
    
}

//MARK: - Empty

public struct EmptyState: State {
    public var name: String { StateMachine._emptyStateName }
    public var controls: [CommandGroup] = []
    
    public init() { }
}
