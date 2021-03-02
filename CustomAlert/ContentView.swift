//
//  ContentView.swift
//  CustomAlert
//
//  Created by mac on 03.03.2021.
//

import SwiftUI

struct ContentView: View {
    @State var title = "MY ALERT"
    @State var secondTitle = "MY SECOND ALERT"
    @State var modalTitle = "MODAL ALERT"
    @ObservedObject var alert: LoadingAlert = LoadingAlert()
    
    @State var isPresentedModal = false
    var body: some View {
        NavigationView {
            VStack {
                Button("Open Alert") {
                    alert.createAlert(title: $title)
                }
                Button("Open Second Alert", action: {
                    alert.createAlert(title: $secondTitle)
                })
                NavigationLink(
                    destination: SecondView(),
                    label: {
                        Text("Open second view")
                    })
                Button("Open On Modal Alert") {
                    isPresentedModal = true
                }.sheet(isPresented: $isPresentedModal, content: {
                    SecondView()
                })
                Spacer()
            }
            .navigationBarTitle("CustomAlert", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SecondView: View {
    @State var secondViewtitle = "SECOND VIEW ALERT"
    @ObservedObject var alert: LoadingAlert = LoadingAlert()
    
    var body: some View {
        Button("Open Alert") {
            alert.createAlert(title: $secondViewtitle)
        }
    }
}
