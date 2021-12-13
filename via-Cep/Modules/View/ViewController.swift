//
//  ViewController.swift
//  via-Cep
//
//  Created by Bruno Vieira Souza on 09/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    let controllerView = Controller()
    
//MARK: - IBOUTLETS
    @IBOutlet weak var lbLogradouro: UILabel!
    @IBOutlet weak var tfCEP: UITextField!
    @IBOutlet weak var lbEstado: UILabel!
    @IBOutlet weak var lbCidade: UILabel!
    @IBOutlet weak var lbBairro: UILabel!
    @IBOutlet weak var lbNumero: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonPesquisar(_ sender: UIButton) {
        controllerView.loadAddress(cep: self.tfCEP.text ?? "78110400") { endereco in
            DispatchQueue.main.async {
                self.lbLogradouro.text = endereco.logradouro
                self.lbNumero.text = endereco.complemento
                self.lbBairro.text = endereco.bairro
                self.lbCidade.text = endereco.localidade
                self.lbEstado.text = endereco.uf
            }
        }
    }
}


