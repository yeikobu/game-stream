//
//  ViewModel.swift
//  GameStream
//
//  Created by Jacob Aguilar on 28-01-22.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject { //Se utiliza una clase debido a que como es por referencia, se puede acceder a desde un objeto a sus propiedades en cualquier parte de la aplicación
    
    @Published var gamesInfo = [Game]() //Un arrelgo de la instancia de game  //La property wrapper Published sirve para indicar que a esta propiedad se puede acceder desde cualquiera que quiera escuchar
    
    init() {
        let url = URL(string: "https://gamestream-api.herokuapp.com/api/games")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET" //Le decimos que el request será de tipo get
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                
                if let jsonData = data {
                    print("Tamańo del json \(jsonData)")
                    
                    let decodeData = try
                    JSONDecoder().decode([Game].self, from: jsonData)
                    
                    DispatchQueue.main.async {
                        self.gamesInfo.append(contentsOf: decodeData)
                    }
                }
                
            } catch {
                print("Error: \(error)")
            }
        }.resume() //Resume es para indicarle al codigo que debe enviar la peticion
    }
    
}
