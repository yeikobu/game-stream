//
//  GamesView.swift
//  GameStream
//
//  Created by Jacob Aguilar on 28-01-22.
//

import SwiftUI
import Kingfisher

struct GamesView: View {
    
    @ObservedObject var allVideoGames = ViewModel() //La vista se comunica siempre con el ViewModel; y el ViewModel se comunica con el modelo
    @State var isGameViewActive: Bool = false
    @State var url: String = ""
    @State var title: String = ""
    @State var studio: String = ""
    @State var calification: String = ""
    @State var publicationYear: String = ""
    @State var description: String = ""
    @State var tags: [String] = [""]
    @State var imgsUrl: [String] = [""]
    let gridForm = [GridItem(.flexible()), GridItem(.flexible())] //De esta forma especificamos la forma en la que se mostrará nuestro grid
    
    var body: some View {
        
        ZStack {
            Color("Background-Color")
                .ignoresSafeArea()
            
            VStack {
                Text("Juegos")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 20, trailing: 0))
                
                ScrollView {
                    LazyVGrid (columns: gridForm, spacing: 8) {
                        ForEach(allVideoGames.gamesInfo, id: \.self) { game in
                            
                            Button {
                                url = game.videosUrls.mobile
                                title = game.title
                                studio = game.studio
                                calification = game.contentRaiting
                                publicationYear = game.publicationYear
                                description = game.description
                                tags = game.tags
                                imgsUrl = game.galleryImages
                                
                                print("Pulsé el juego \(title)")
                                
                                isGameViewActive = true
                            } label: {
                                
                                VStack {
                                    //Mostrar imagenes de una url/api con una libreria de terceros compatible con todas las versiones de iOS
                                    KFImage(URL(string: game.galleryImages[0])!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle.init(cornerRadius: 12))
                                        
                                    Text(game.title)
                                        .foregroundColor(.white)
                                        .font(.system(size: 11, weight: .bold, design: .rounded))
                                        .padding(.bottom, 11)
                                            
                                }
                                
                                
                                //Mostrar imagenes version SwiftUI desde iOS 15+
//                                 AsyncImage(url: URL(string: game.galleryImages[0])!)
//                                    .frame(width: 200, height: 150)
                                
                                    
                            }

                        }
                    }
                }
                .cornerRadius(12)
                Spacer()
            }.padding(.horizontal, 6)
            
            NavigationLink(isActive: $isGameViewActive) {
                GameView(url: url, title: title, studio: studio, calification: calification, publicationYear: publicationYear, description: description, tags: tags, imgsUrl: imgsUrl)
            } label: {
                EmptyView()
            }

        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView()
    }
}
