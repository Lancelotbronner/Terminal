import SwiftUI

@available(OSX 10.15.0, *)
public typealias Built<V: View> = () -> V

@available(OSX 10.15.0, *)
@_functionBuilder
final class ViewBuilder {

//    static func buildBlock() -> Empty {
//        Empty()
//    }
    
    static func buildBlock<V: View>(_ c: V) -> V {
        c
    }
    
    static func buildBlock<C1, C2>(_ c1: C1, _ c2: C2) -> Tupple2<C1, C2> {
        Tupple2(c1, c2)
    }
    
    static func buildBlock<C1, C2, C3>(_ c1: C1, _ c2: C2, _ c3: C3) -> Tupple3<C1, C2, C3> {
        Tupple3(c1, c2, c3)
    }
    
    static func buildBlock<C1, C2, C3, C4>(_ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> Tupple4<C1, C2, C3, C4> {
        Tupple4(c1, c2, c3, c4)
    }
    
}
