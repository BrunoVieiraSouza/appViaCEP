//
//  API.swift
//  via-Cep
//
//  Created by Bruno Vieira Souza on 09/12/21.
//

import Foundation

//MARK: - ENUM TRATAMENTO DE ERROS
enum CepError: Error {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJson
}

class API {
    //MARK: - CRIANDO SESSÃO
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    //MARK: - REQUISICAO DA API
    
    static func loadAddress (cep: String, completion: @escaping(Endereco) -> Void, onError: @escaping(CepError) -> Void ) {
        guard let url = URL(string: "https://viacep.com.br/ws/\(cep)/json") else {
            onError(.url)
            return
        }
        let data = session.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    
                    do {
                        let endereco = try JSONDecoder().decode(Endereco.self, from: data)
                        completion(endereco)
                    } catch {
                        onError(.invalidJson)
                        print("não foi possivel retornar o Json")
                    }
                } else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else {
                onError(.taskError(error: error!))
                print("erro ao fazer dataTask")
            }
        }
        data.resume()
    }
}
