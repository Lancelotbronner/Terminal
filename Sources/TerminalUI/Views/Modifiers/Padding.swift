@available(OSX 10.15.0, *)
struct Padding: Presentable, View {
    
    //MARK: - Properties
    
    let content: Presentable
    let edges: Edges
    let spacing: Int
    
    var spacingH: Int { edges.countH * spacing }
    var spacingV: Int { edges.countV * spacing }
    
    //MARK: - Initialization
    
    init(_ v: Presentable, _ e: Edges, _ s: Int) {
        content = v
        edges = e
        spacing = s
    }
    
    //MARK: - View
    
    public var queryWidth: Length { content.queryWidth + spacingH.toLength }
    public var queryHeight: Length { content.queryHeight + spacingV.toLength }
    
    func draw(in rect: Rect) {
        content.draw(in: Rect(
            rect.x + (edges.hasLeading ? 1 : 0),
            rect.y + (edges.hasBottom ? 1 : 0),
            rect.width - (edges.hasTrailing ? 1 : 0),
            rect.height - (edges.hasTop ? 1 : 0)))
    }
    
}
