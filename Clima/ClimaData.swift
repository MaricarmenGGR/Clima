//
//  ClimaData.swift
//  Clima
//
//  Created by Catalina on 18/11/20.
//

import Foundation

struct ClimaData : Decodable {
    let name : String
    let timezone : Int
    let main : Main
    let coord : Coord
}

struct Main : Decodable {
    let temp : Double
}

struct Coord : Decodable{
    let lon : Double
    let lat : Double
}
