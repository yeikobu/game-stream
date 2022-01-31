//
//  FavoritesView.swift
//  GameStream
//
//  Created by Jacob Aguilar on 30-01-22.
//

import SwiftUI
import AVKit

struct FavoritesView: View {
    
    @ObservedObject var allVideoGames = ViewModel()
    
    var body: some View {
        ZStack {
            Color("Background-Color")
                .ignoresSafeArea()
            
            VStack {
                Text("FAVORITOS")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 9)
                
                ScrollView(showsIndicators: false) {
                    ForEach(allVideoGames.gamesInfo, id: \.self) { game in
                        VStack(spacing: 0) {
                            VideoPlayer(player: AVPlayer(url: URL(string: game.videosUrls.mobile)!))
                                .frame(height: 300)
                            
                            Text(game.title)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color("Buttons-Blue"))
                        }
                        .cornerRadius(12)
                        .padding(.bottom, 12)
                    }
                }
                .padding(.bottom, 12)
            }
            .padding(.horizontal, 6)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
