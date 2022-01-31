//
//  SaveData.swift
//  GameStream
//
//  Created by Jacob Aguilar on 30-01-22.
//

import Foundation
import SwiftUI

class SaveData {

    var email: String = ""
    var pass: String = ""
    var userName: String = ""
    
    func saveDatas(email: String, pass: String, name: String) -> Bool {
        print("Dentro de la funcion save data obtubimos: \(email) + \(pass) + \(name)")
        
        UserDefaults.standard.set([email, pass, name], forKey: "userDatas")
        
        return true
    }
    
    func receibeDatas() -> [String] {
        let userData: [String] = UserDefaults.standard.stringArray(forKey: "userDatas")! // De esta forma podemos recuperar los datos desde UserDefaults
        
        print("En el metodo receibeDatas recuperé \(userData)")
        
        return userData
    }
    
    func validate(email: String, pass: String) -> Bool {
        var savedEmail: String = ""
        var savedPass: String = ""
        
        print("Datos en user defaults: Email: \(savedEmail) y conrtraseña \(savedPass)")
        
        if UserDefaults.standard.objectIsForced(forKey: "userDatas") != false {
            savedEmail = UserDefaults.standard.stringArray(forKey: "userDatas")![0]
            savedPass =  UserDefaults.standard.stringArray(forKey: "userDatas")![1]
            print("Correo guardado: \(savedEmail)      Cotraseña guardada: \(savedPass)")
            
            if (email == savedEmail && pass == savedPass) {
                return true
            } else {
                return false
            }
        } else {
            print("No hay datos de usuario guardados en User Defaults")
            return false
        }
    }
    
    func signUp(email: String, pass: String) {
        print("Dentro de la funcion signUp obtubimos: \(email) + \(pass)")
        
        UserDefaults.standard.set([email, pass], forKey: "userDatas")
    }
    
}
