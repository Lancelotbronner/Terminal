public final class NavigationView: View {
    
    //MARK: - Properties
    
    var items: [View] = []
    var contents: View
    
    //MARK: - Initialization
    
    init(_ c: View) {
        contents = c
    }
    
    //MARK: - Methods
    
    func with(_ nav: View) {
        items.append(nav)
    }
    
    //MARK: - View
    
    public var queryWidth: Length { .infinity }
    public var queryHeight: Length { contents.queryHeight + 2 }
    
    public func draw(in rect: Rect) {
        
    }
    
}
