import Terminal

//MARK: - User view

@available(OSX 10.15.0, *)
public protocol View {
    associatedtype Body: View
    var body: Body { get }
}

@available(OSX 10.15.0, *)
extension View {
    
    var asPresentable: Presentable { (self as? Presentable) ?? body.asPresentable }
    
    var asPresentables: [Presentable] {
        if let tupple = self as? Views { return tupple.presentables }
        else { return [asPresentable] }
    }
    
}

//MARK: - Modifiers

@available(OSX 10.15.0, *)
extension View {
    
    public func background<V: View>(alignment a: Alignment = .center, @ViewBuilder _ view: Built<V>) -> some View {
        ZStack(alignment: a) {
            view()
            self
        }
    }
    
    public func overlay<V: View>(alignment a: Alignment = .center, @ViewBuilder _ view: Built<V>, clipToBounds: Bool = true) -> some View {
        ZStack(alignment: a) {
            self
            view()
        }
    }
    
    public func frame(width: Length? = nil, height: Length? = nil) -> some View {
        Frame(asPresentable, width, height)
    }
    
    public func padding(_ length: Int, _ edges: Edges = .all) -> some View {
        Padding(asPresentable, edges, length)
    }
    
    public func border(_ width: Int, char: Character? = nil, foreground: Foreground? = nil, background: Background? = nil, style: Style? = nil) -> some View {
        Border(asPresentable, width, char, foreground, background, style)
    }
    
}
