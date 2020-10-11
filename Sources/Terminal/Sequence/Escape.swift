//
//  File.swift
//  
//
//  Created by Christophe Bronner on 17/04/2020.
//

//MARK: - Escape

extension Sequence {
    public enum Escape: String {
        
        //MARK: Cases
        
        case csi = "\u{1b}["
        
    }
}
