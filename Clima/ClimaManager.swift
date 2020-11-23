//
//  ClimaManager.swift
//  Clima
//
//  Created by Catalina on 17/11/20.
//

import Foundation

protocol ClimaManagerDelegate{
    func actualizarClima(clima : ClimaModelo)
    
    func huboError(cualError : Error)
}

struct ClimaManager {
    
    var delegado : ClimaManagerDelegate?
    
    let climaURL = "https://api.openweathermap.org/data/2.5/weather?appid=481c3f56dd564f999cdd85940ab390e8&lang=es&units=metric"
    func fetchClima(nombreCiudad : String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q="+nombreCiudad+"&appid=481c3f56dd564f999cdd85940ab390e8&lang=es&units=metric"
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
                    //print(error!.localizedDescription)
                    delegado?.huboError(cualError: error!)
                    return
                }
                if let datosSeguros = data {
                    //Necesitamos convertir la data a String
                    if let clima = parseJSON(climaData: datosSeguros){
                        delegado?.actualizarClima(clima: clima)
                    }
                }
                
            }
            //Empezar la tarea
            tarea.resume()
            
        }
        
    }
    //Metodo para Parsear el JSON
    func parseJSON(climaData : Data) -> ClimaModelo? {
        let decoder = JSONDecoder()
        
        do{
        let dataDecodificada = try decoder.decode(ClimaData.self, from: climaData)
            let idClima = dataDecodificada.weather[0].id
            let nombreCiudad = dataDecodificada.name
            let temperaturaCelsius = dataDecodificada.main.temp
            let descripcionCiudad = dataDecodificada.weather[0].description
            let imagen = dataDecodificada.weather[0].icon
            
            //Creacion de obj ClimaModelo
            
            let ObjClima = ClimaModelo(condicionID: idClima, nombreCiudad: nombreCiudad, temperaturaCelsius: temperaturaCelsius, descripcionCiudad: descripcionCiudad, icon: imagen)
            
            return ObjClima
            
        }catch{
            print(error)
            delegado?.huboError(cualError: error)
            return nil
        }
        
        
    }
}
