//
//  ContentView.swift
//  GameStream
//
//  Created by Jacob Aguilar on 26-01-22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                
                Spacer()
                
                Color("Background-Color")
                    .ignoresSafeArea()
                
                VStack {
                    Image("AppLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                        .padding(.bottom, 40)
                    
                    SignInAndSingUpView()
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle()) //Esta linea de codigo se utiliza para que en el iPad se mustre la primera pantalla de manera correcta
    }
}

struct SignInAndSingUpView: View {
    
    @State var siginInType = true
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                
                Button {
                    siginInType = true
                } label: {
                    Text("INICIA SESIÓN")
                        .foregroundColor(siginInType ? .white : .gray)
                }
                
                Spacer()
                
                Button {
                    siginInType = false
                } label: {
                    Text("REGÍSTRATE")
                        .foregroundColor(siginInType ? .gray : .white)
                }
                
                Spacer()
            }
            
            Spacer(minLength: 42)
            
            if siginInType == true {
                SiginInView()
            } else {
                SiginUpView()
            }
            
        }
    }
}

//Struct de la vista de inicio de sesion
struct SiginInView: View {
    
    @State var email = ""
    @State var password = ""
    @State var isHomeViewActive = false
    @State var ifNotUserFound = false
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                //Input Correo
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
                
                //Input contraseña
                Text("Contraseña")
                    .fontWeight(.bold)
                    .foregroundColor(password.isEmpty ? Color("Dark-Cian") : Color(.white))
                
                ZStack(alignment: .leading) {
                    
                    if password.isEmpty {
                        Text("escribe tu contraseña")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    SecureField("", text:  $password)
                        .foregroundColor(.white)
                }
                
                Divider()
                    .frame(height: 1)
                    .background(password.isEmpty ? Color("Dark-Cian") : Color(.gray))
                    .padding(.bottom)
                
                 
                Text("¿Olvidaste tu contraseña?")
                    .foregroundColor(Color("Dark-Cian"))
                    .font(.footnote)
                    .frame(width: 300, alignment: .trailing)
                    .padding(.bottom)
                
                Button {
                    signin()
                } label: {
                    Text("INICIAR SESIÓN")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color("Dark-Cian"), lineWidth: 1.5))
                        .shadow(color: Color("Dark-Cian"), radius: 2)
                }
                .padding(.vertical, 40)
                .alert(isPresented: $ifNotUserFound) {
                    Alert(title: Text("Error"), message: Text("Correo o contaseña incorrencotos"), dismissButton: .default(Text("Entendido")))
                }
                
                
                Text("Inicia sesión con redes sociales")
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                //Botones redes sociales
                HStack {
                    
                    //Botón de inicio con facebook
                    Button {
                        print("Facebook")
                    } label: {
                        Text("Facebook")
                            .fontWeight(.bold)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("Buttons-Blue"))
                            .cornerRadius(12)
                    }
                    
                    //Botón de inicio con twitter
                    Button {
                        print("Twitter")
                    } label: {
                        Text("Twitter")
                            .fontWeight(.bold)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("Buttons-Blue"))
                            .cornerRadius(12)
                    }
                    
                }
                .padding(.top, 10)
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 40)
            
            NavigationLink(isActive: $isHomeViewActive) {
                HomeView()
            } label: {
                Text("")
            }
           
        }
    }
    
    //método para login
    func signin() {
        let updateDataObject = SaveData()
        let result = updateDataObject.validate(email: self.email, pass: self.password)
        
        if result == true {
            ifNotUserFound = false
            isHomeViewActive = true
        } else {
            ifNotUserFound = true
        }
    }

}


//Struct de la vista de registro
struct SiginUpView: View {
    
    @State var email: String = ""
    @State var pass: String = ""
    @State var repass: String = ""
    @State var isHomeViewActive = false
    @State var isPassNotConfirmed = false
    let updateDataObject = SaveData()
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .center) {
                
                Text("Elije una foto de perfil")
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("Puedes cambiarla o elegirla más adelante")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .padding(.top, 1)
                
                ZStack {
                    
                    Button {
                        takePicture()
                    } label: {
                        
                        ZStack {
                            Image("imagenperfil")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: "camera")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                        }
                        
                    }

                }
                .padding()
                
                VStack(alignment: .leading) {
                    //Input Correo
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
                    
                    //Input contraseña
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
                    
                    //Input contraseña
                    Text("Confirmar contraseña")
                        .fontWeight(.bold)
                        .foregroundColor(repass.isEmpty ? Color("Dark-Cian") : Color(.white))
                    
                    ZStack(alignment: .leading) {
                        
                        if repass.isEmpty {
                            Text("confirma tu contraseña")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        SecureField("", text:  $repass)
                            .foregroundColor(.white)
                    }
                    
                    Divider()
                        .frame(height: 1)
                        .background(repass.isEmpty ? Color("Dark-Cian") : Color(.gray))
                        .padding(.bottom, 40)
                    
                    
                    VStack {
                        //BOTON REGISTRAR
                        Button {
                            if pass != repass {
                                isPassNotConfirmed = true
                            } else {
                                isPassNotConfirmed = false
                                updateDataObject.signUp(email: self.email, pass: self.pass)
                                isHomeViewActive = true
                            }
                        } label: {
                            Text("REGISTRARSE")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                                .overlay(RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color("Dark-Cian"), lineWidth: 1.5))
                                .shadow(color: Color("Dark-Cian"), radius: 2)
                        }
                        .alert(isPresented: $isPassNotConfirmed) {
                            Alert(title: Text("Error"), message: Text("Las contraseñas no coinciden"), dismissButton: .default(Text("Entendido")))
                        }
                        
                        
                        Text("Inicia sesión con redes sociales")
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        //Botones redes sociales
                        HStack {
                            
                            //Botón de inicio con facebook
                            Button {
                                print("Facebook")
                            } label: {
                                Text("Facebook")
                                    .fontWeight(.bold)
                                    .frame(height: 40)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(Color("Buttons-Blue"))
                                    .cornerRadius(12)
                            }
                            
                            //Botón de inicio con twitter
                            Button {
                                print("Twitter")
                            } label: {
                                Text("Twitter")
                                    .fontWeight(.bold)
                                    .frame(height: 40)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(Color("Buttons-Blue"))
                                    .cornerRadius(12)
                            }
                            
                        }
                        .padding(.top, 10)
                    }
                   
                    
                    
                    
                
                }
               
                
            }
            .padding(.horizontal, 20)
            
            NavigationLink(isActive: $isHomeViewActive) {
                HomeView()
            } label: {
                EmptyView()
            }

            
        }
                        
    }
    
    func takePicture() {
        print("tomar foto")
    }
    
    func signup() {
        
        
       
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
        
    }
}

