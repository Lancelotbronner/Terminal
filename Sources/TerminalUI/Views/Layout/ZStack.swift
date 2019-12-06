@available(OSX 10.15.0, *)
public struct ZStack: Presentable {
    
    //MARK: - Properties
    
    let alignment: Alignment
    let items: [Presentable]
    
    //MARK: - Initialization
    
    init(alignment a: Alignment = .center, _ contents: Presentable...) {
        items = contents
        alignment = a
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
