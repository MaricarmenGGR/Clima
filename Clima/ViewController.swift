//
//  ViewController.swift
//  Clima
//
//  Created by Catalina on 13/11/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    let climaManager = ClimaManager()
    
    @IBOutlet weak var climaImageView: UIImageView!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var BuscarTextField: UITextField!
    @IBOutlet weak var ciudadLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
    }
    
}

