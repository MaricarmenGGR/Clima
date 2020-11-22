//
//  ClimaData.swift
//  Clima
//
//  Created by Catalina on 18/11/20.
//

import Foundation

struct ClimaData : Codable {
    let name : String
    let timezone : Int
    let main : Main
    let coord : Coord
    let weather : [Weather]
}

struct Main : Codable {
    let temp : Double
}

struct Coord : Codable{
    let lon : Double
    let lat : Double
}

struct Weather : Codable {
    let id : Int
    let description : String
    let icon : String
}

