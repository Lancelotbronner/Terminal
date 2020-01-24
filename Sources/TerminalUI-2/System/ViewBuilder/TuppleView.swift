
//MARK: - Tupple Views

struct Tupple2<V1, V2>: Views, View where V1: View, V2: View {
    
    let presentables: [Presentable]
    
    init(_ v1: V1, _ v2: V2) {
        presentables = [v1.asPresentable,
                        v2.asPresentable]
    }
    
}

struct Tupple3<V1, V2, V3>: Views, View where V1: View, V2: View, V3: View {
    
    let presentables: [Presentable]
    
    init(_ v1: V1, _ v2: V2, _ v3: V3) {
        presentables = [v1.asPresentable,
                        v2.asPresentable,
                        v3.asPresentable]
    }
    
}

struct Tupple4<V1, V2, V3, V4>: Views, View where V1: View, V2: View, V3: View, V4: View {
    
    let presentables: [Presentable]
    
    init(_ v1: V1, _ v2: V2, _ v3: V3, _ v4: V4) {
        presentables = [v1.asPresentable,
                        v2.asPresentable,
                        v3.asPresentable,
                        v4.asPresentable]
    }
    
}
