//
//  ClimaManager.swift
//  Clima
//
//  Created by Catalina on 17/11/20.
//

import Foundation

struct ClimaManager {
    let climaURL = "http://api.openweathermap.org/data/2.5/weather?q=Morelia&appid=481c3f56dd564f999cdd85940ab390e8"
    
    func fetchClima(nombreCiudad : String) {
        let urlString = "http://api.openweathermap.org/data/2.5/weather?q="+nombreCiudad+"&appid=481c3f56dd564f999cdd85940ab390e8"
        print(urlString)
    }
    
    func realizarSolicitud(urlString : String) {
        //-----NETWORKING-----//
        //Creacion de Url
        if let url = URL(string: urlString){
            //Crear  obj URLSession
            let session = URLSession(configuration: .default)
            //Dar una tarea a la sesion
            let tarea =  session.dataTask(with: url, completionHandler: handle(data:respuesta:error:))
            //Empezar la tarea
            tarea.resume()
            
        }
        
    }
    
    func handle(data:Data?, respuesta:URLResponse?, error : Error?){
        if error != nil{
            print(error!.localizedDescription)
            return
        }
        if let datosSeguros = data {
            //Necesitamos convertir la data a String
            let dataString = String(data: datosSeguros, encoding: .utf8)
            print(dataString!)
        }
    }
}
