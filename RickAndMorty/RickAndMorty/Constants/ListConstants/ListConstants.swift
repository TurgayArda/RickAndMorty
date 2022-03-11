//
//  ListConstants.swift
//  RickAndMorty
//
//  Created by ArdaSisli on 12.03.2022.
//

import Foundation

final class ListContants {
    enum SegmentItems: String {
        case grid = "Grid"
        case list = "List"
    }
    
    enum SearchBar: String {
        case placeHolder = "Search movie name"
        case scopeTitleAll = "All"
        case scopeTitleAlive = "Alive"
        case scopeTitleDead = "Dead"
        case scopeTitleunknown = "unknown"
    }
    
    enum Alert: String {
        case alertTitle = "Error"
        case actionTitle = "OK"
    }
}
