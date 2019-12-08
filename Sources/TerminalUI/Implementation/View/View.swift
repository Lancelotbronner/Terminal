
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
