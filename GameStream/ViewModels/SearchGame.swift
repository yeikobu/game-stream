//
//  SearchGame.swift
//  GameStream
//
//  Created by Jacob Aguilar on 29-01-22.
//

import Foundation

class SearchGame: ObservableObject {
    
    @Published var gameInfo = [Game]()
    
    func search(gameName: String) {
        
        gameInfo.removeAll() //Con este metodo eliminamos del arreglo todas las informacion almacenada anteriormente
        let gameNameSpaces = gameName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //Esto se utiliza para evitar que la url tenga espacios
        let url = URL(string: "https://gamestream-api.herokuapp.com/api/games/search?contains=\(gameNameSpaces ?? "cuphead")")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET" //Le decimos que el request será de tipo get
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let jsonData = data {
                    print("Tamańo del json \(jsonData)")
        
                    let decodeData = try
                    JSONDecoder().decode(Results.self, from: jsonData)
        
                    DispatchQueue.main.async {
                        self.gameInfo.append(contentsOf: decodeData.results)
                    }
                }
        
            } catch {
                print("Error: \(error)")
            }
        }.resume() //Resume es para indicarle al codigo que debe enviar la peticion
    }

}
