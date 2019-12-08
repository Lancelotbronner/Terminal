@available(OSX 10.15.0, *)
public struct ZStack: Presentable, View {
    
    //MARK: - Properties
    
    let alignment: Alignment
    let items: [Presentable]
    
    //MARK: - Initialization
    
    init(_ a: Alignment = .center, _ contents: [Presentable]) {
        items = contents
        alignment = a
    }
    
    public init<V: View>(alignment a: Alignment = .center, @ViewBuilder _ contents: Built<V>) {
        self.init(a, contents().asPresentables)
    }
    
    //MARK: - View
    
    public var queryHeight: Length { items.heights.max }
    public var queryWidth: Length { items.widths.max }
    
    public func draw(in rect: Rect) {
        for item in items {
            Align(item, alignment).draw(in: rect)
        }
    }
    
}
