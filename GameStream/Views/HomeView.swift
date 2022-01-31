//
//  HomeView.swift
//  GameStream
//
//  Created by Jacob Aguilar on 27-01-22.
//

import SwiftUI
import AVKit

struct HomeView: View {
    
    @State var selectedTab: Int = 2
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Perfil")
                }.tag(0)
            
            GamesView()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Juegos")
                }.tag(1)
            
            Home()
                .tabItem {
                    Image(systemName: "house")
                    Text("Inicio")
                }.tag(2)
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favoritos")
                }.tag(3)
        }
        .accentColor(.white)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
    
    //Inicializador para poder cambiar el fondo del tab bar usando UIKit
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "TabBar-Color")
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().standardAppearance = appearance

        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
   
}

struct Home: View {
    
    
    
    var body: some View {
        ZStack {
            
            Color("Background-Color").ignoresSafeArea()
            
            VStack {
                
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .padding(.horizontal, 11)
                
                
                
                ScrollView(showsIndicators: false) {
                    SubHomeModule()
                }
                .cornerRadius(12)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        
    }
    
}

struct SubHomeModule: View {
    
    @ObservedObject var foundGame = SearchGame()
    @State var isGameViewActive = false
    @State var searchText = ""
    @State var isPlayerActive = false
    @State var isGameInfoEmpty = false
    @State var url: String = ""
    @State var title: String = ""
    @State var studio: String = ""
    @State var calification: String = ""
    @State var publicationYear: String = ""
    @State var description: String = ""
    @State var tags: [String] = [""]
    @State var imgsUrl: [String] = [""]
    
    var body: some View {
        VStack {
            
            HStack {
                
                Button {
                    searchGame(name: searchText)
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(searchText.isEmpty ? Color(.yellow) : Color("Dark-Cian"))
                }
                .alert(isPresented: $isGameInfoEmpty) {
                    Alert(title: Text("Error"), message: Text("No se encontró el juego"), dismissButton: .default(Text("Entendido")))
                }
                
                ZStack(alignment: .leading) {
                    if searchText.isEmpty {
                        Text("Buscar un video")
                            .foregroundColor(Color(red: 174/255, green: 177/255, blue: 185/255, opacity: 1.0))
                    }
                    
                    TextField("", text: $searchText)
                        .foregroundColor(.white)
                }

            }
            .padding([.top, .leading, .bottom], 11)
            .background(Color("Buttons-Blue"))
            .clipShape(Capsule())
            
            Text("MÁS POPULARES")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            ZStack {
                Button {
                    searchGame(name: "the witcher")
                } label: {
                    VStack(spacing: 0) {
                        Image("thewitcher")
                            .resizable()
                            .scaledToFill()
                        Text("The Witcher 3")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .background(Color("Buttons-Blue"))
                    }
                }
                .cornerRadius(12)
                
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 42, height: 42)

            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            
            Text("CATEGORÍAS SUGERIDAS PARA TI")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack {
                    
                    Button {
                        print("categoria fps")
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color("Buttons-Blue"))
                                .frame(width: 160, height: 90)
                            
                            Image("fps")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                    }
                    
                    Button {
                        print("categoria rpg")
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color("Buttons-Blue"))
                                .frame(width: 160, height: 90)
                            
                            Image("rpg")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                    }
                    
                    Button {
                        print("categoria open world")
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color("Buttons-Blue"))
                                .frame(width: 160, height: 90)
                            
                            Image("openworld")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                    }

                }
            }
            
            Text("RECOMENDADOS PARA TI")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    
                    Button {
                        searchGame(name: "Abzu")
                    } label: {
                        Image("Abzu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                            .cornerRadius(12)
                    }
                    
                    Button {
                        searchGame(name: "CrashBandicoot")
                    } label: {
                        Image("CrashBandicoot")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                            .cornerRadius(12)
                    }
                    
                    Button {
                        searchGame(name: "DeathStranding")
                    } label: {
                        Image("DeathStranding")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                            .cornerRadius(12)
                    }
                }
            }
            
            Text("VIDEOS QUE PODRÍAN GUSTARTE")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    
                    Button {
                        searchGame(name: "Cuphead")
                    } label: {
                        Image("Cuphead")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                            .cornerRadius(12)
                    }
                    
                    Button {
                        searchGame(name: "Hades")
                    } label: {
                        Image("Hades")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                            .cornerRadius(12)
                    }
                    
                    Button {
                        searchGame(name: "GTAV")
                    } label: {
                        Image("GTAV")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                            .cornerRadius(12)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        NavigationLink(isActive: $isGameViewActive) {
            GameView(url: url, title: title, studio: studio, calification: calification, publicationYear: publicationYear, description: description, tags: tags, imgsUrl: imgsUrl)
        } label: {
            EmptyView()
        }


    }
    
    func searchGame(name: String) {
        foundGame.search(gameName: name)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            print("Cantidad elementos: \(foundGame.gameInfo.count)")
            if foundGame.gameInfo.count == 0 {
                isGameInfoEmpty = true
            } else {
                url = foundGame.gameInfo[0].videosUrls.mobile
                title = foundGame.gameInfo[0].title
                studio = foundGame.gameInfo[0].studio
                calification = foundGame.gameInfo[0].contentRaiting
                publicationYear = foundGame.gameInfo[0].publicationYear
                description = foundGame.gameInfo[0].description
                tags = foundGame.gameInfo[0].tags
                imgsUrl = foundGame.gameInfo[0].galleryImages
                
                isGameViewActive = true
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
