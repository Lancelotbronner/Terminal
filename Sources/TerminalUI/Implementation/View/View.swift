
//MARK: - User view

@available(OSX 10.15.0, *)
public protocol View {
    associatedtype Body: View
    var body: Body { get }
}

@available(OSX 10.15.0, *)
extension View {
    
    var asPresentable: Presentable { (body as? Presentable) ?? body.asPresentable }
    
}
