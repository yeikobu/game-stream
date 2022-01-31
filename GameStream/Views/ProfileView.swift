//
//  ProfileView.swift
//  GameStream
//
//  Created by Jacob Aguilar on 30-01-22.
//

import SwiftUI

struct ProfileView: View {
    
    @State var userName: String = "Lorem"
    @State var profileImage: UIImage = UIImage(named: "imagenperfil")!
    
    var body: some View {
        ZStack {
            
            Color("Background-Color")
                .ignoresSafeArea()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            
            VStack {
                Text("PERFIL")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
                VStack {
                    Image(uiImage: profileImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 118, height: 118)
                        .cornerRadius(200)
                    
                    Text("Jacob Aguilar")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 32, trailing: 0))
                
                Text("Ajustes")
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 18)
                
                SettingsModule()
                
            }
            
        }
        .onAppear {
            
            if returnUiImage(named: "fotoperfil") != nil {
                profileImage = returnUiImage(named: "fotoperfil")!
            } else {
                print("No encontré foto de perdil guardada en el dispositivo")
            }
                
                
//            if UserDefaults.standard.object(forKey: "userDatas") != nil {
//                userName = UserDefaults.standard.stringArray(forKey: "userDatas")![2]
//            }
        }
    }
    
    func returnUiImage(named: String) -> UIImage? {
        
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        
        return nil
    }
}

struct SettingsModule: View {
    
    @State var isToggleOn = true
    @State var isEditProfileViewActive = false
    
    var body: some View {
        
        VStack {
            
            Button {
                print("")
            } label: {
                HStack {
                    Text("Cuenta")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color("Buttons-Blue"))
                .cornerRadius(12)
                .padding(.horizontal, 5)
            }
            
            Button {
                isToggleOn.toggle()
            } label: {
                HStack {
                    Text("Notificaciones")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Toggle(isOn: $isToggleOn) {
                        Text("")
                    }
                    .frame(width: 12, height: 12, alignment: .trailing)
                }
                .padding()
                .background(Color("Buttons-Blue"))
                .cornerRadius(12)
                .padding(.horizontal, 5)
            }
             
            Button {
                isEditProfileViewActive = true
            } label: {
                HStack {
                    Text("Editar perfil")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color("Buttons-Blue"))
                .cornerRadius(12)
                .padding(.horizontal, 5)
            }
            
            Button {
                print("")
            } label: {
                HStack {
                    Text("Califica esta aplicación")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color("Buttons-Blue"))
                .cornerRadius(12)
                .padding(.horizontal, 5)
            }
            
            Spacer()
            
            NavigationLink(isActive: $isEditProfileViewActive) {
                EditProfileView()
            } label: {
                EmptyView()
            }

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
