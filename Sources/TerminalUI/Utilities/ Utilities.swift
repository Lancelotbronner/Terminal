extension HostingView {
    
    //MARK: - Methods
    
    static func getMaximumHeight(in views: [View]) -> Length {
        getMaximum(in: views.map { $0.queryHeight })
    }
    
    static func getMaximum(in queries: [Length]) -> Length {
        var largest: Length = 0
        for q in queries {
            guard !q.isInfinity else { return .infinity }
            if q > largest { largest = q }
        }
        return largest
    }
    
}
