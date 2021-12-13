//
//  Controller.swift
//  via-Cep
//
//  Created by Bruno Vieira Souza on 13/12/21.
//

import Foundation

class Controller {
    
   func loadAddress (cep: String, success: @escaping (Endereco) -> Void) {
        API.loadAddress(cep: cep) { endereco in
            success(endereco)
        } onError: { Error in
            print("api nao funcinou")
        }
    }
}
