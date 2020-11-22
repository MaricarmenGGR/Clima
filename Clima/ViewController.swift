//
//  ViewController.swift
//  Clima
//
//  Created by Catalina on 13/11/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, ClimaManagerDelegate {
    var climaIcono : String = ""
    var climanombreCiudad : String = ""
    var climaDescrip : String = ""
    var temperaturaClima : String = ""
    
    var climaManager = ClimaManager()
    
    func actualizarClima(clima: ClimaModelo) {
        self.climaDescrip = clima.descripcionCiudad
        self.climanombreCiudad = clima.nombreCiudad
        self.temperaturaClima = String(clima.temperaturaCelsius)
        self.climaIcono = clima.icon
        print(climaIcono)
        print(clima.temperaturaCelsius)
    }
    
    
    
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
        
        if BuscarTextField.text == ""{
            let alertaNada = UIAlertController(title: "No hay Ciudad", message: "El lugar que intentas ingresar NO es valido", preferredStyle: .alert)
            
            let actionNada = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            
            alertaNada.addAction(actionNada)
            present(alertaNada, animated: true, completion: nil)
            
        }
        
        reflejarDatos()
        reflejarDatos()
        
    }
    
    func reflejarDatos(){
        ciudadLabel.text = BuscarTextField.text
        climaManager.fetchClima(nombreCiudad: BuscarTextField.text!)
        temperaturaLabel.text = temperaturaClima + "º C"
        descripcionClimaLabel.text = climaDescrip
        print("El icono"+climaIcono)
        let url = NSURL(string: "https://openweathermap.org/img/wn/"+climaIcono+"@2x.png")
        print(url!)
        if let data = NSData(contentsOf: url! as URL) {
            climaImageView.image = UIImage(data: data as Data)
        }
    }
    

}

