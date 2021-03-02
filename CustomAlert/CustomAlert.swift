//
//  CustomAlert.swift
//  CustomAlert
//
//  Created by mac on 03.03.2021.
//

import SwiftUI

struct CustomAlert: View {
    @Binding var isPresented: Bool
    @Binding var title: String

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(title)
                    .font(.title)
                Button("Close") {
                    isPresented = false
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}
