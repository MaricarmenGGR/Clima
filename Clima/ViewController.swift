//
//  ViewController.swift
//  Clima
//
//  Created by Catalina on 13/11/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, ClimaManagerDelegate {
    var climaIcono : String = ""
    var climaManager = ClimaManager()
    
    func huboError(cualError: Error) {
        DispatchQueue.main.async {
            self.descripcionClimaLabel.text = "NOT FOUND"
            self.ciudadLabel.text = "Ciudad NO Encontrada"
            self.temperaturaLabel.text = "0º C"
            self.climaImageView.image = #imageLiteral(resourceName: "mikusad_preview_rev_1")
        }
    }
    
    func actualizarClima(clima: ClimaModelo) {
        
        self.climaIcono = clima.icon
        print(climaIcono)
        print(clima.temperaturaCelsius)
        
        
        DispatchQueue.main.async {
            self.temperaturaLabel.text = String(clima.temperaturaCelsius)
            self.descripcionClimaLabel.text = clima.descripcionCiudad
            self.ciudadLabel.text = clima.nombreCiudad
            self.fondoClimaImage.image = UIImage(named: clima.obtenerCondicionClima)
            //Consumir ICONS desde la API
            print("El icono"+self.climaIcono)
            let url = NSURL(string: "https://openweathermap.org/img/wn/"+self.climaIcono+"@2x.png")
            print(url!)
            if let data = NSData(contentsOf: url! as URL) {
                self.climaImageView.image = UIImage(data: data as Data)
            }
            
            
        }
        
        
    }
    
    
    
    @IBOutlet weak var fondoClimaImage: UIImageView!
    @IBOutlet weak var descripcionClimaLabel: UILabel!
    @IBOutlet weak var climaImageView: UIImageView!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var BuscarTextField: UITextField!
    @IBOutlet weak var ciudadLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        climaManager.delegado = self
        
        BuscarTextField.delegate = self
        
        
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
    
    func reflejarDatos(){
        DispatchQueue.main.async {
            print("El icono"+self.climaIcono)
            let url = NSURL(string: "https://openweathermap.org/img/wn/"+self.climaIcono+"@2x.png")
            print(url!)
            if let data = NSData(contentsOf: url! as URL) {
                self.climaImageView.image = UIImage(data: data as Data)
            }
            
        }
        
    }
    

}

