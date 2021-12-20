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
    let levels = ["Makkelijk", "Normaal", "Moeilijk"]
    
    var body: some View {
            VStack{
                Image("checkout")
                    .cornerRadius(30)
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
                HStack{
                    Spacer()
                }
                Text("Kies een niveau:")
                    .font(Font.system(size: 30, weight: .heavy, design: .rounded))
                Picker("Kies een niveau", selection: $startViewModel.level) {
                        ForEach(levels, id: \.self) {
                            Text($0)
                                .font(Font.system(size: 28, weight: .heavy, design: .rounded))
                        }
                    }
                .pickerStyle(.inline)
                Spacer()
                Button(action: {
                    AudioServicesPlaySystemSound(1100)
                    audioPlayer?.stop()
                    if startViewModel.level == "Makkelijk"{
                        nextViewModel.setNameAndLevel(store: startViewModel.storeOption, level: 1)
                    }else if startViewModel.level == "Normaal"{
                        nextViewModel.setNameAndLevel(store: startViewModel.storeOption, level: 2)
                    }else{
                        nextViewModel.setNameAndLevel(store: startViewModel.storeOption, level: 3)
                    }
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
            .onAppear(perform: {
                playSound(sound: "backgroundm", type: "mp3")
            })
       }
}



struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        let startViewModel = StartViewModel()
        let nextViewModel  = CheckoutViewModel()
        StartView(startViewModel: startViewModel, nextViewModel: nextViewModel)
    }
}
