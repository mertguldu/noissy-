//
//  InvitePage.swift
//  noissy
//
//  Created by Mert Guldu on 3/17/24.
//

import SwiftUI

struct InvitePage: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    @State var textField: String = ""
    @FocusState var isTextFieldFocudes: Bool
    
    var password = "MakeNoisse"
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
                    .foregroundStyle(Color.white.opacity(0.6))
                    
            }
            .focused($isTextFieldFocudes)
            .multilineTextAlignment(.center)
            .textContentType(.none)
            .foregroundStyle(.white)
            .frame(width: 300, height: 50)
            .background(
                RoundedRectangle(cornerSize: CGSizeMake(10, 10))
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
    }
}

#Preview {
    InvitePage(feedViewModel: FeedViewModel())
}
