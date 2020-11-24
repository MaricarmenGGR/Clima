//
//  ClimaModelo.swift
//  Clima
//
//  Created by Catalina on 21/11/20.
//

import Foundation
struct ClimaModelo {
    let condicionID : Int
    let nombreCiudad : String
    let temperaturaCelsius : Double
    let descripcionCiudad : String
    let tempMax : Double
    let tempMin : Double
    let presion : Int
    let humedad : Int
    let icon : String
    
    
    //Haciendo la propiedad Computada
    
    var obtenerCondicionClima : String {
        switch condicionID {
        case 200...222:
            return "tormenta.jpeg"
        case 300...322:
            return "drizi.jpeg"
        case 500...531:
            return "lluvia.jpeg"
        case 600...622:
            return "nieve.jpeg"
        case 800...806:
            return "cieloclaro.jpeg"
        default:
            return "ciudadBlancos.jpeg"
        }
        
    }
    
}
