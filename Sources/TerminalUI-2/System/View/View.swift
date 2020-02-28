
//MARK: - View

public protocol View {
    associatedtype Body: View
    var body: Body { get }
}
extension View {
    
    var asPresentable: Presentable { self as? Presentable ?? body.asPresentable }
    
}

extension View where Self: Presentable {
    
    func environement(
    
}

//MARK: - Views

protocol Views: View {
    var presentables: [Presentable] { get }
}

extension Views {
    public var body: some View { Empty() }
}