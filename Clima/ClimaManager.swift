//
//  ClimaManager.swift
//  Clima
//
//  Created by Catalina on 17/11/20.
//

import Foundation

struct ClimaManager {
    let climaURL = "https://api.openweathermap.org/data/2.5/weather?q=Morelia&appid=481c3f56dd564f999cdd85940ab390e8"
    
    func fetchClima(nombreCiudad : String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q="+nombreCiudad+"&appid=481c3f56dd564f999cdd85940ab390e8"
        print(urlString)
        
        realizarSolicitud(urlString: urlString)
        
    }
    
    func realizarSolicitud(urlString : String) {
        //-----NETWORKING-----//
        //Creacion de Url
        if let url = URL(string: urlString){
            //Crear  obj URLSession
            let session = URLSession(configuration: .default)
            //Dar una tarea a la sesion
            //let tarea =  session.dataTask(with: url, completionHandler: handle(data:respuesta:error:))
            let tarea = session.dataTask(with: url) { (data, respuesta, error) in
                if error != nil{
                    print(error!.localizedDescription)
                    return
                }
                if let datosSeguros = data {
                    //Necesitamos convertir la data a String
                    parseJSON(climaData: datosSeguros)
                }
                
            }
            //Empezar la tarea
            tarea.resume()
            
        }
        
    }
    //Metodo para Parsear el JSON
    func parseJSON(climaData : Data) {
        let decoder = JSONDecoder()
        
        do{
        let dataDecodificada = try decoder.decode(ClimaData.self, from: climaData)
            print(dataDecodificada.name)
            print(dataDecodificada.timezone)
            print(dataDecodificada.main.temp)
            print("Latitud: \(dataDecodificada.coord.lat)")
            print("Longitud \(dataDecodificada.coord.lon)")
            
        }catch{
            print(error)
        }
        
        
    }
}
