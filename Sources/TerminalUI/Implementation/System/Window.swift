import Terminal

@available(OSX 10.15.0, *)
public struct Window {
    
    //MARK: - Properties
    
    let root: Presentable
    
    let alignment: Alignment
    let screen: Rect
    
    //MARK: - Initialization
    
    init(_ v: Presentable, _ s: Rect? = nil, _ a: Alignment = .center) {
        root = v
        alignment = a
        screen = s ?? Rect(Terminal.width, Terminal.height)
    }
    
    public init<V: View>(size: Rect? = nil, alignment a: Alignment = .center, @ViewBuilder _ view: Built<V>) {
        self.init(view().asPresentable, size, a)
        display()
    }
    
    //MARK: - Methods
    
    func display() {
        Align(root, alignment).draw(in: screen)
    }
    
}
