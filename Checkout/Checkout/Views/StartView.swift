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
    @State var playBtnDisabled = true
    @State var goToNextView: Bool = false
    @State var btnOpacity: CGFloat = 0.5
   
    var body: some View {
     
            VStack{
                Image("checkout")
                    .cornerRadius(30)
                Spacer()
                //input for player name
                VStack{
                    Text("Wat is jouw spelernaam?")
                        .font(Font.system(size: 30, weight: .heavy, design: .rounded))
                    TextField("Spelernaam...", text: $startViewModel.playerName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .font(Font.system(size: 16, weight: .heavy, design: .rounded))
                        .frame(width: 300)
                        .onChange(of: startViewModel.playerName){newValue in
                            if newValue != "" {
                                self.playBtnDisabled = false
                                self.btnOpacity = 1
                            }
                        }
                }
                Spacer()
                HStack{
                    VStack{
                        Text("Kies een winkel:")
                            .font(Font.system(size: 30, weight: .heavy, design: .rounded))
                        Picker("Kies een winkel", selection: $startViewModel.storeOption) {
                            ForEach(Stores.stores, id: \.self) {
                                    Text($0)
                                        .font(Font.system(size: 28, weight: .heavy, design: .rounded))
                                }
                            }
                            .pickerStyle(.inline)
                    }
                    Spacer()
                    VStack{
                        Text("Kies een niveau:")
                            .font(Font.system(size: 30, weight: .heavy, design: .rounded))
                        Picker("Kies een niveau", selection: $startViewModel.level) {
                            ForEach(Levels.levels, id: \.self) {
                                    Text($0)
                                        .font(Font.system(size: 28, weight: .heavy, design: .rounded))
                                }
                            }
                        .pickerStyle(.inline)
                    }
                }
               
                Spacer()
                Button(action: {
                    AudioServicesPlaySystemSound(1100)
                    audioPlayer?.stop()
                    startViewModel.checkIfPlayerExist()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                        arrangeGameStart()
                    }
                    
                         }){
                           Text("Speel")
                                 .font(Font.system(size: 30, weight: .heavy, design: .rounded))
                                 .padding()
                         }.fullScreenCover(isPresented: $goToNextView, content: {
                                    CheckoutView(viewModel: nextViewModel)
                                })
                    .foregroundColor(.black)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(40)
                    .opacity(btnOpacity)
                    .disabled(self.playBtnDisabled)
            }
            .padding()
            .background(
                GeometryReader{ geo in
                    Image("home")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width * 1, height: geo.size.height * 1)
                        .opacity(0.5)
                }
            )
            .onAppear(perform: {
                playSound(sound: "backgroundm", type: "mp3")
                Task{
                    do{
                        try await startViewModel.getPlayers()
                    }catch{
                        print("Error creating player \(error)")
                    }
                }
            })
       }
    
    func arrangeGameStart(){
        nextViewModel.player = startViewModel.currentPlayer
        if startViewModel.level == "Makkelijk"{
            nextViewModel.setNameAndLevel(store: startViewModel.storeOption, level: 1)
        }else if startViewModel.level == "Normaal"{
            nextViewModel.setNameAndLevel(store: startViewModel.storeOption, level: 2)
        }else{
            nextViewModel.setNameAndLevel(store: startViewModel.storeOption, level: 3)
        }
        goToNextView.toggle()
    }

}



struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        let startViewModel = StartViewModel()
        let nextViewModel  = CheckoutViewModel()
        StartView(startViewModel: startViewModel, nextViewModel: nextViewModel)
.previewInterfaceOrientation(.landscapeRight)
    }
}
