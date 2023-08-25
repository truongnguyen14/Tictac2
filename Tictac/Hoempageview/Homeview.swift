//
//  Homeview.swift
//  Tictac
//
//  Created by Truong, Nguyen Tan on 26/08/2023.
//

import SwiftUI

struct Homeview: View {
    
    @State private var showinghowtoplayview = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Menubackgroundcolor()
                VStack {
                    VStack{
                        Spacer()
                        Text("Choose a game mode")
                            .foregroundColor(.white)
                            .font(.system(size: 20,weight: .bold))
                        NavigationLink{
                            Map2()
                        }label: {
                            Text("Map 2")
                                .padding()
                        }
                        .modifier(Buttonmodifier())
                        .padding()
                        
                        NavigationLink{
                            Map2()
                        }label: {
                            Text("Map 2")
                                .padding()
                        }
                        .modifier(Buttonmodifier())
                        .padding()
                        
                        NavigationLink{
                            Map2()
                        }label: {
                            Text("Map 2")
                                .padding()
                        }
                        .modifier(Buttonmodifier())
                        .padding()
                    }
                    
                    Spacer()
                    
                    VStack{
                        Button(action: {
                            self.showinghowtoplayview = true
                        }) {
                            Text("How To Play")
                                .padding(15)
                        }
                        .modifier(Buttonfunction(color: Color("Blue")))
                        .modifier(Shadow())
                        .padding()
                        
                        NavigationLink{
                            Setting()
                        }label: {
                            Text("Setting")
                                .padding(15)
                        }
                        .modifier(Buttonfunction(color: Color("Blue")))
                        .modifier(Shadow())
                        .padding()
                    }
                }
            }
        }.sheet(isPresented: $showinghowtoplayview) {
            Informationview()
          }
    }
}

struct Homeview_Previews: PreviewProvider {
    static var previews: some View {
        Homeview()
    }
}
