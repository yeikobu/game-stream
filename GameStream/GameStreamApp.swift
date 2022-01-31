//
//  GameStreamApp.swift
//  GameStream
//
//  Created by Jacob Aguilar on 26-01-22.
//

import SwiftUI

@main
struct GameStreamApp: App {
    
    @Environment(\.scenePhase) var scenePhase //Para poder controlar el ciclo de vida de la app
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            
            //La aplicacion tiene 3 estados en el ciclo de vida: Active, Inactive y Backround
        }.onChange(of: scenePhase) { phase in
            if phase == .inactive {
                print("La app está inactiva, guardaré todos los datos para usarlos cuando esté activo nuevamente ")
                
                
            }
        }
    }
}
