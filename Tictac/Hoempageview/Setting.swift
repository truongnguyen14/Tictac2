//
//  Setting.swift
//  Tictac
//
//  Created by Truong, Nguyen Tan on 28/08/2023.
//

import SwiftUI

struct Setting: View {
    @State private var showingInformationview = false
    
    var body: some View {
        ZStack{
            Menubackgroundcolor()
            VStack{
                Button(action: {
                    self.showingInformationview = true
                }) {
                    Text("App information")
                        .padding(8)
                }
                .modifier(Buttonfunction(color: Color("Blue")))
            }
        }
        .sheet(isPresented: $showingInformationview) {
            Informationview()
          }
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
    }
}
