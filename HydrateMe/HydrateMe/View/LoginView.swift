//
//  LoginView.swift
//  HydrateMe
//
//  Created by english on 2025-03-06.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isEmailValid = true
    @State private var isPasswordValid = true
    @State private var isLoggedIn = false
    @State private var errorMsg = ""
    @State private var alert = false
    
    
    
    var body: some View {
        NavigationView {
            ZStack {

                Image("underwater")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
                VStack(alignment: .center){
                    Text("Hydrate Me")
        //                .font(.system(size: 70, weight: .bold, design: Font.Design?))
                        //.f
                    HStack {
                        Text("Powered by")
                        //CSS
                        Text("H2O")
                            .bold()
                            .foregroundColor()
                        //CSS
                    }
    
                    
                    VStack {

                        Text("Login")
                        //CSS
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .onChange(of: email) { newValue in
                                isEmailValid = isValidEmail(newValue)
                                errorMsg = isEmailValid ? "" : "Please enter a valid email address."
                                alert = !isEmailValid
                            }
                            //CSS
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .onChange(of: password) { newValue in
                                isPasswordValid = isValidPassword(newValue)
                                //errorMsg = getPasswordValidationError(newValue)
                                alert = !isPasswordValid
                            }
                            //CSS
                        
                        Button(action: {
                            if isPasswordValid && isEmailValid {
                                FirebaseModel.shared.signIn(email: email, password: password) { result in
                                    switch result {
                                    case .success(let user):
                                        print("User signed in: \(user.email ?? "")")
                                    case .failure(let error):
                                        errorMsg = error.localizedDescription
                                    }
                                }
                            } else {
                                errorMsg = "Please enter both email and password"
                            }
                        }) {
                            Image("")// Use the image path which
                            //CSS
                        }
            
                        HStack {
                                Text("Don't have an account?")
                                //CSS
                                NavigationLink("Sign up", destination: SignUpView())
                                //CSS
                        }
                        .padding()
                    }
                    .padding()
                    .background(RoundedRectangle(corner Radius: 20).fill(Color.blue.opacity(0.9)))
                    .padding()
                }
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let minLenght = 8
        let regexLower = "(?=.*[a-z])"
        let regexUpper = "(?=.*[A-Z])"
        let regexDigit = "(?=.*\\d)"
        
        let predicateL = NSPredicate(format: "SELF MATCHES[c] %@", regexLower)
        let predicateU = NSPredicate(format: "SELF MATCHES[c] %@", regexUpper)
        let predicateD = NSPredicate(format: "SELF MATCHES[c] %@", regexDigit)
        
        return password.count >= minLenght &&
        predicateD.evaluate(with: password) &&
        predicateL.evaluate(with: password) &&
        predicateU.evaluate(with: password)
    }
    
    private func getPasswordValidationError(_ password: String) -> String {
        let minLength = 8
        var errorMsg = ""
        
        if password.count < minLength {
            errorMsg += "Password must be at least \(minLength) characters long."
        }
        if !NSPredicate(format: "SELF MATCHES %@", "(?=.*[a-z])").evaluate(with: password) {
            errorMsg += "\nPassword must contain at least one lower case letter."
        }
        if !NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])").evaluate(with: password) {
            errorMsg += "\nPassword must contain at least one upper case letter."
        }
        if !NSPredicate(format: "SELF MATCHES %@", "(?=.*\\d)").evaluate(with: password) {
            errorMsg += "\nPassword must contain at least one digit."
        }
        
        return errorMsg
    }
    
    public func isValidPassword(_ password: String) -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: password)
    }
}

#Preview {
    LoginView()
}
