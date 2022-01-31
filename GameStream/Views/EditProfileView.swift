//
//  EditProfileView.swift
//  GameStream
//
//  Created by Jacob Aguilar on 30-01-22.
//

import SwiftUI

struct EditProfileView: View {
    
    @State var profileImage: Image? = Image("imagenperfil")
    @State var isCameraActive = false
    
    var body: some View {
        ZStack {
            Color("Background-Color")
                .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    VStack {
                        
                       // SUImagePickerView(sourceType: .photoLibrary, image: $profileImage, isPresented: $isCameraActive)
                        
                        Button {
                            isCameraActive = true
                        } label: {
                            ZStack {
                                profileImage!
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 118, height: 118)
                                    .cornerRadius(200)
                                    .sheet(isPresented: $isCameraActive, content: {
                                        SUImagePickerView(sourceType: .photoLibrary, image: $profileImage, isPresented: $isCameraActive)
                                    })

                                
                                Image(systemName: "camera")
                                    .foregroundColor(.white)
                                    .font(.system(size: 22))
                            }
                        }

                    }
                    .padding(.bottom, 18)
                    
                    EditModule()
                    
                    
                }
            }
        }
    }
}

struct EditModule: View {
    
    @State var email: String = ""
    @State var pass: String = ""
    @State var userName: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Correo electrónico")
                .fontWeight(.bold)
                .foregroundColor(email.isEmpty ? Color("Dark-Cian") : Color(.white))
            
            ZStack(alignment: .leading) {
                if email.isEmpty {
                    Text(verbatim: "correo@gmail.com")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                TextField("", text:  $email)
                    .foregroundColor(.white)
            }
            
            Divider()
                .frame(height: 1)
                .background(email.isEmpty ? Color("Dark-Cian") : Color(.gray))
                .padding(.bottom)
            
            
            Text("Contraseña")
                .fontWeight(.bold)
                .foregroundColor(pass.isEmpty ? Color("Dark-Cian") : Color(.white))
            
            ZStack(alignment: .leading) {
                
                if pass.isEmpty {
                    Text("escribe tu contraseña")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                SecureField("", text:  $pass)
                    .foregroundColor(.white)
            }
            
            Divider()
                .frame(height: 1)
                .background(pass.isEmpty ? Color("Dark-Cian") : Color(.gray))
                .padding(.bottom)
            
            
            Text("Nombre usuario")
                .fontWeight(.bold)
                .foregroundColor(email.isEmpty ? Color("Dark-Cian") : Color(.white))
            
            ZStack(alignment: .leading) {
                if userName.isEmpty {
                    Text(verbatim: "Introduce nombre de usuario")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                TextField("", text:  $userName)
                    .foregroundColor(.white)
            }
            
            Divider()
                .frame(height: 1)
                .background(userName.isEmpty ? Color("Dark-Cian") : Color(.gray))
                .padding(.bottom)
            
            
            VStack {
                Button {
                    updateData()
                } label: {
                    Text("GUARDAR CAMBIOS")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color("Dark-Cian"), lineWidth: 1.5))
                        .shadow(color: Color("Dark-Cian"), radius: 2)
                }
            }
            .padding(.top, 40)
        }
        .padding(.horizontal, 20)
    }
    
    func updateData() {
        let updaterDataObject = SaveData()
        let result = updaterDataObject.saveDatas(email: email, pass: pass, name: userName)
        
        print("Datos guradados con exito? \(result)")
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
