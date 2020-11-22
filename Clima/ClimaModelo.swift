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
    let icon : String
    
    
    //Haciendo la propiedad Computada
    
    var obtenerCondicionClima : String {
        switch condicionID {
        case 200...222:
            return "wind"
        case 300...322:
            return "wind"
        default:
            return "cloud"
        }
        
    }
    
}
