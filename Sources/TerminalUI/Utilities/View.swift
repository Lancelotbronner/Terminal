//MARK: - View

public protocol View {
    func draw(in rect: Rect)
    
    var queryWidth: Length { get }
    var queryHeight: Length { get }
}

extension View {
    
    public func frame(width: Length? = nil, height: Length? = nil) -> View {
        Frame(self, width, height)
    }
    
}

//MARK: - Empty View

struct Empty: View {
    func draw(in rect: Rect) { }
    var queryWidth: Length { 0 }
    var queryHeight: Length { 0 }
}
