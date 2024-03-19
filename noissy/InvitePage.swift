//
//  InvitePage.swift
//  noissy

// A view that display the entrance page for new users. If the users have the password, they can enter. Otherwise, they are not invited, yet.

import SwiftUI

struct InvitePage: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    @State var textField: String = ""
    @State var showAlert: Bool = false
        
    var password = "MakeNoisse" //Invite Only Password
    
    var body: some View {
        VStack {
            Image("logo-crop")
                .resizable()
                .frame(width: 125, height: 125)
                .padding()
                .padding(.top, -100)
                .padding(.bottom, 100)
            
            SecureField(text: $textField) {
                Text("invite password")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white.opacity(0.8))
                    
            }
            .multilineTextAlignment(.center)
            .textContentType(.none)
            .foregroundStyle(.white)
            .frame(width: 300, height: 50)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.8, green: 0, blue: 0.8))
            )
            .padding()
            .padding(.bottom, 50)
            
            Button {
                if textField == password {
                    print("password is correct")
                    
                    withAnimation(.easeIn.delay(0)) {
                        feedViewModel.invite()
                    }
                    
                } else {
                    print("password is incorrect")
                    showAlert = true
                }
            } label: {
                Text("Enter")
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 0.8, green: 0, blue: 0.8))
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(mainColor)
        .alert(Text("Wrong Password. Try Again."), isPresented: $showAlert) {
            Button {
                showAlert = false
            } label: {
                Text("OK")
            }

        }
    }
}

#Preview {
    InvitePage(feedViewModel: FeedViewModel())
}
