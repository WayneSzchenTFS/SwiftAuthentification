//
//  SignInEmailView.swift
//  SwiftAuthentification
//
//  Created by Wayne Chen on 2023-04-30.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject
{
    @Published var email = ""
    @Published var password = ""
    
    
    func signIn()
    {
        guard !email.isEmpty, !password.isEmpty else
        {print ("Pas de courriel et/ou mot de passe")
            return
        }
        Task{
            do{
                let returnedUserData = try await AuthentificationManager.shared.createUser(email: email, password: password)
                print("Usager créé")
                print(returnedUserData)
                }catch
            {
                    print("Erreur: \(error)")
            }
        
        }
    }//
}

struct SignInEmailView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    var body: some View {
        VStack
        {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            SecureField("Mot de passe...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            
            Button{
                viewModel.signIn()
            }label: {
                Text("Se connecter")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
            }
        .padding()
        .navigationTitle("Login avec email")
        }
    }

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack
        {
            SignInEmailView()
        }
    }
}
