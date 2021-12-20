//
//  StartView.swift
//  Checkout
//
//  Created by Jordi Dewit on 19/12/2021.
//

import SwiftUI
import AVFoundation

struct StartView: View {
    @ObservedObject var startViewModel: StartViewModel
    @ObservedObject var nextViewModel: CheckoutViewModel
    @State var goToNextView: Bool = false
    let stores = ["Bakkerij", "Beenhouwerij", "Fruitwinkel", "Groentewinkel", "Speelgoedwinkel", "Sportwinkel"]
    
    var body: some View {
            VStack{
                Text("CHECKOUT")
                    .font(Font.system(size: 50, weight: .heavy, design: .rounded))
                Spacer()
                Text("Kies een winkel:")
                    .font(Font.system(size: 30, weight: .heavy, design: .rounded))
                Picker("Kies een winkel", selection: $startViewModel.storeOption) {
                        ForEach(stores, id: \.self) {
                            Text($0)
                                .font(Font.system(size: 28, weight: .heavy, design: .rounded))
                        }
                    }
                .pickerStyle(.inline)
                Spacer()
                HStack{
                    Spacer()
                }
                Button(action: {
                    AudioServicesPlaySystemSound(1100)
                    nextViewModel.setName(store: startViewModel.storeOption)
                    goToNextView.toggle()
                         }){
                           Text("Speel")
                                 .font(Font.system(size: 30, weight: .heavy, design: .rounded))
                                 .padding()
                         }.fullScreenCover(isPresented: $goToNextView, content: {
                                    CheckoutView(viewModel: nextViewModel)
                                })
                    .padding()
                    .foregroundColor(.black)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(40)
            }
            .padding()
            .background(
                Image("home")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .opacity(0.5)
                )
       }
}



struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        let startViewModel = StartViewModel()
        let nextViewModel  = CheckoutViewModel()
        StartView(startViewModel: startViewModel, nextViewModel: nextViewModel)
    }
}
