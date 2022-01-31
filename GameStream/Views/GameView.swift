//
//  GameView.swift
//  GameStream
//
//  Created by Jacob Aguilar on 29-01-22.
//

import SwiftUI
import AVKit
import Kingfisher

struct GameView: View {
    
    //Cuandro traemos datos que vienen desde otra pantalla no se deben inicializar. Pero en la structura del preview, para poder mostrar el canvas, se deben pasar parámetros estáticos
    var url: String
    var title: String
    var studio: String
    var calification: String
    var publicationYear: String
    var description: String
    var tags: [String]
    var imgsUrl: [String]
    
    var body: some View {
        ZStack {
            
            
            Color("Background-Color")
                .ignoresSafeArea()
            
            VStack {
                GameVideo(url: url)
                    .frame(height: 300)
                
                ScrollView {
                    GameInfo(title: title, studio: studio, calification: calification, publicationYear: publicationYear, description: description, tags: tags)
                        .padding(.bottom)
                    
                    Gallery(imgsUrl: imgsUrl)
                    
                    Comments()
                    
                    Comment(uname: "Jacob Aguilar", comment: "He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades", daysAgo: 7)
                    
                    Comment(uname: "Luis Contreras", comment: "He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades", daysAgo: 10)
                    
                    
                }
                .frame(maxWidth: .infinity)
                .cornerRadius(12)
            }
        }
    }
}

struct GameVideo: View {
    
    var url: String
    
    var body: some View {
        
        let player = AVPlayer(url: URL(string: url)!)
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onDisappear(perform: player.pause)
            
            
    }
}
                
struct GameInfo: View {
    
    var title, studio, calification, publicationYear, description: String
    var tags: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding(.horizontal)
            
            HStack {
                Text(studio)
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.leading)
                    .padding(.top, -20)
                
                Text(calification)
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.leading)
                    .padding(.top, -20)
                
                Text(publicationYear)
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.leading)
                    .padding(.top, -20)
            }
            
            Text(description)
                .foregroundColor(.white)
                .font(.subheadline)
                .padding(.top, 5)
                .padding(.horizontal)
            
            HStack {
                ForEach(tags, id: \.self) { tag in
                    Text("#\(tag)")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.top, 5)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct Gallery: View {
    
    var imgsUrl: [String]
    let gridForm = [GridItem(.flexible())]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("GALERÍA")
                .foregroundColor(.white)
                .font(.title)
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridForm, spacing: 8) {
                    ForEach(imgsUrl, id: \.self) { imgUrl in
                        KFImage(URL(string: imgUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(12)
                    }
                }
            }
            .frame(height:180)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
    }
}


struct Comments: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("COMENTARIOS")
                .foregroundColor(.white)
                .font(.title)
                .padding(.leading)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
    }
}

struct Comment: View {
    
    var uname: String
    var comment: String
    var daysAgo: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    Image("imagenperfil")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    
                    VStack(alignment: .leading) {
                        Text(uname)
                            .foregroundColor(.white)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        
                        Text("Hace 7 días")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                    }
                    .padding(.leading, 3)
                }
                .padding(.leading, 20)
                .padding(.top)
                
                Text(comment)
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.horizontal, 20)
                    .padding(.bottom)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("Buttons-Blue"))
            .cornerRadius(12)
            .padding(.horizontal)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 5)
    }
}

struct GameView_Previews: PreviewProvider { //En estra preview, como no tenemos las propiedades de la estructura de la View inicializadas, no podemos mostrar los datos en el canvas, por esa razón debemos pasarle datos estáticos, para que no nos muestre un error si es que queremos ver o trabajar con el canvas
    static var previews: some View {
        GameView(url: "ejemplo.com", title: "Sonic", studio: "Sega", calification: "E+", publicationYear: "1992", description: "Juego de Sega Genesis publicado en 1991 con más de 40 millones de copias vendidas actualmente", tags: ["plataformas","mascota"], imgsUrl: ["https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg"])
    }
}
