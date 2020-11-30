//
//  ViewController.swift
//  Clima
//
//  Created by Catalina on 13/11/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    var locationManager = CLLocationManager()
    var climaIcono : String = ""
    var climaManager = ClimaManager()
    
    
    @IBOutlet weak var humedadLabel: UILabel!
    @IBOutlet weak var Presion: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var fondoClimaImage: UIImageView!
    @IBOutlet weak var descripcionClimaLabel: UILabel!
    @IBOutlet weak var climaImageView: UIImageView!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var BuscarTextField: UITextField!
    @IBOutlet weak var ciudadLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        climaManager.delegado = self
        
        BuscarTextField.delegate = self
    }
    
    @IBAction func ubicacionButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    //Boton de Buscar en Interfaz
    @IBAction func BuscarButton(_ sender: UIButton) {
        ciudadLabel.text = BuscarTextField.text
        climaManager.fetchClima(nombreCiudad: BuscarTextField.text!)
        //reflejarDatos()
        if BuscarTextField.text == ""{
            let alertaNada = UIAlertController(title: "No hay Ciudad", message: "El lugar que intentas ingresar NO es valido", preferredStyle: .alert)
            let actionNada = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertaNada.addAction(actionNada)
            present(alertaNada, animated: true, completion: nil)
            
        }
    }
}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Ubicacion Obtenida")
        if let ubicacion = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = ubicacion.coordinate.latitude
            let lon = ubicacion.coordinate.longitude
            print("\(lat)+:::+\(lon)")
            climaManager.fetchClima(lat: lat, lon: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Imprimir:  ///"+error.localizedDescription)
    }
}


//MARK: -Delegado para Consumir API
extension ViewController : ClimaManagerDelegate{
    func huboError(cualError: Error) {
        DispatchQueue.main.async {
            let error = String(cualError.localizedDescription)
            if(error=="The data couldn’t be read because it is missing."){
                self.descripcionClimaLabel.text = "SIN CIUDAD"
                self.ciudadLabel.text = "Proporciona una Ciudad"
                self.temperaturaLabel.text = "0 ºC"
                self.climaImageView.image = #imageLiteral(resourceName: "mikusad_preview_rev_1")
                self.tempMinLabel.text = "❌"
                self.tempMaxLabel.text = "❌"
                self.Presion.text = "❌"
                self.humedadLabel.text = "❌"
                
            }
            if(error=="The data couldn’t be read because it is missing." && self.BuscarTextField.text != ""){
                self.descripcionClimaLabel.text = "CIUDAD NO VALIDA"
                self.ciudadLabel.text = "Verifica la ciudad proporcionada"
                self.temperaturaLabel.text = "0 ºC"
                self.climaImageView.image = #imageLiteral(resourceName: "mikusad_preview_rev_1")
                self.tempMinLabel.text = "❌"
                self.tempMaxLabel.text = "❌"
                self.Presion.text = "❌"
                self.humedadLabel.text = "❌"
            }
            
            print(cualError.localizedDescription)
        }
    }
    
    func actualizarClima(clima: ClimaModelo) {
        
        self.climaIcono = clima.icon
        print(climaIcono)
        print(clima.temperaturaCelsius)
        
        
        DispatchQueue.main.async {
            self.temperaturaLabel.text = String(clima.temperaturaCelsius)+"º C"
            self.descripcionClimaLabel.text = "En la Ciudad de "+clima.nombreCiudad+" esta "+clima.descripcionCiudad
            self.ciudadLabel.text = "Ciudad: "+clima.nombreCiudad
            self.fondoClimaImage.image = UIImage(named: clima.obtenerCondicionClima)
            self.tempMaxLabel.text = "🥵 TempMax: \(clima.tempMax)"
            self.tempMinLabel.text = "🥶 TempMin: \(clima.tempMin)"
            self.Presion.text = "🌡 Presion: \(clima.presion)"
            self.humedadLabel.text = "💧Humedad: \(clima.humedad)"
            //Consumir ICONS desde la API
            print("El icono"+self.climaIcono)
            let url = NSURL(string: "https://openweathermap.org/img/wn/"+self.climaIcono+"@2x.png")
            print(url!)
            if let data = NSData(contentsOf: url! as URL) {
                self.climaImageView.image = UIImage(data: data as Data)
            }
        }
    }
    
}

//MARK: -DelegadoParaText
extension ViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        BuscarTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ciudadLabel.text = BuscarTextField.text
        return true
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if BuscarTextField.text != ""{
            return true
        }else{
            BuscarTextField.placeholder = "Escribe una Ciudad"
            return false
        }
    }
    
}


