import Terminal

struct Text: Presentable, View {
    
    //MARK: - Properties
    
    var environement: Environement?
    private let text: String
    
    //MARK: - Initialization
    
    public init(_ txt: String) {
        text = txt
    }
    
    //MARK: - Presentable
    
    var queryWidth: Length { .init(text.count) }
    var queryHeight: Length { 1 }
    
    func draw(in rect: Rect) {
        Terminal.goto(rect.leftX, rect.bottomY)
        Terminal.write(design: text,
                       color: env.color,
                       background: env.background,
                       style: env.style)
    }
    
}
