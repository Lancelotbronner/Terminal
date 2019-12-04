//MARK: - View

public protocol View {
    func draw(in rect: Rect)
    
    var queryWidth: Length { get }
    var queryHeight: Length { get }
}

//MARK: - Empty View

struct Empty: View {
    func draw(in rect: Rect) { }
    var queryWidth: Length { 0 }
    var queryHeight: Length { 0 }
}
