//
//  Endereco.swift
//  via-Cep
//
//  Created by Bruno Vieira Souza on 09/12/21.
//
import Foundation

// MARK: - Welcome
struct Endereco: Codable {
    let cep, logradouro, complemento, bairro: String
    let localidade, uf, ibge, gia: String
    let ddd, siafi: String
}
