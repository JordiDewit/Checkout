//  Created by Jordi Dewit on 23/11/2021.
//  This is the main view of the checkout game
//  This view will show a store, product and the currency where the
//  user has to pay with to buy the product


import SwiftUI
import AVFoundation

// main view
struct CheckoutView: View {
    
    // viewmodel dependency
    @ObservedObject var viewModel: CheckoutViewModel
    @State var goToStartingView: Bool = false
    @State var gameIsOver: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    
   
    var body: some View {
        VStack{
            Spacer(minLength: 20)
            HStack{
                Text(viewModel.getStoreName().uppercased())
                    .font(.system(size: Constants.fontSize2, weight: .heavy, design: .rounded))
                        .transition(.opacity)
                Spacer()
                Text("Score: \(viewModel.getScore())/5")
                    .font(Font.system(size: Constants.fontSize2, weight: .heavy, design: .rounded))
            }
            VStack{
                ProductView(show: viewModel.productOnScreen)
                cashRegister
                HStack{
                    Text("€ \(viewModel.payed, specifier: "%.2f")")
                        .font(Font.system(size: Constants.fontSize2, weight: .heavy, design: .rounded))
                    Image(systemName: "delete.backward")
                        .onTapGesture {
                            withAnimation{
                                viewModel.giveMoney(payed: -viewModel.payed)
                                AudioServicesPlaySystemSound(1100)
                            }
                        }
                        .font(Font.system(size: Constants.fontSize2, weight: .heavy, design: .rounded))
                }
                .padding()
                
            }
                Spacer()
                moneyView
                Spacer()
            HStack{
                stopGame
                Spacer()
                payProduct
            }
            Spacer(minLength: 20)
        }
        .padding()
        .background(
            GeometryReader{ geo in
                Image("store")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width * 1, height: geo.size.height * 1)
                    .opacity(0.5)
            }
        )
    }
    // the cash register which receives the money
    var cashRegister: some View {
        Image("cashRegister")
            .resizable()
            .frame(width: Constants.crSize, height: Constants.crSize)
            .onDrop(of: ["public.text"], delegate: dropDelegate(viewModel: viewModel))
    }
    // button to quit the game*9-
    var stopGame: some View {
        Button(
           action: {
               AudioServicesPlaySystemSound(1100)
               gameIsOver = false
               goToStartingView.toggle()
        },
           label: {
               Text("Stop")
                   .font(Font.system(size: 26, weight: .heavy, design: .rounded))
        }).fullScreenCover(isPresented: $goToStartingView, content: {
            //fresh start initial entry
            StartView(startViewModel: StartViewModel(), nextViewModel: CheckoutViewModel())
        })
        .padding()
        .foregroundColor(.black)
        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.yellow]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(40)
    }
    // pay a product button
    var payProduct: some View {
        Button(
           action: {
               withAnimation{
                   viewModel.pay(for: viewModel.productOnScreen)
                   AudioServicesPlaySystemSound(1100)
                   if viewModel.isOver() {
                       gameIsOver = true
                       playSound(sound: "end", type: "mp3")
                       viewModel.addScoreToScoreBoard()
                   }
               }
        },
           label: {
               Text("Betaal")
                   .font(Font.system(size: 26, weight: .heavy, design: .rounded))
           }).fullScreenCover(isPresented: $gameIsOver, content: {
               endView
        })
        .padding()
        .foregroundColor(.black)
        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(40)
    }
    
    var deletePlayer: some View {
        Button(
           action: {
               withAnimation{
                   AudioServicesPlaySystemSound(1100)
                   gameIsOver = false
                   goToStartingView.toggle()
                   Task{
                       do{
                           try await viewModel.deleteCurrentPlayer()
                       }catch{
                           print("Error when deleting: \(error)")
                       }
                   }
               }
        },
           label: {
               Text("Verwijder speler")
                   .font(Font.system(size: 26, weight: .heavy, design: .rounded))
           }).fullScreenCover(isPresented: $goToStartingView, content: {
               //fresh start initial entry
               StartView(startViewModel: StartViewModel(), nextViewModel: CheckoutViewModel())
        })
        .padding()
        .foregroundColor(.black)
        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.yellow]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(40)
    }
    
    // money grid
    var moneyView: some View {
        
        let layout = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        return LazyHGrid(rows: layout, spacing: 20){
            ForEach(viewModel.getCash(), id: \.self) { value in
                    if(value > 2){
                        let img: String = compareCashValue(from: value)
                            Image(img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 140, height: 70)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 3))
                            .shadow(radius: 10)
                            .onDrag{
                                NSItemProvider(object: String(value) as NSString)
                            }
                    }else{
                        let img: String = compareCashValue(from: value)
                        Image(img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .overlay(RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 3))
                            .shadow(radius: 50)
                            .onDrag{
                                NSItemProvider(object: String(value) as NSString)
                            }
                    }
                }
        }
        .padding(.all, -11.0)
    }
    
    var endView: some View {
        VStack{
            Text("Jouw score:")
                .font(.system(size: Constants.fontSize2, weight: .heavy, design: .rounded))
                    .transition(.opacity)
            Spacer()
            Text("\(viewModel.getScore())/5")
                .font(.system(size: Constants.fontSize2, weight: .heavy, design: .rounded))
                    .transition(.opacity)
            Text(compareScore(for: viewModel.getScore()))
                .font(.system(size: Constants.fontSize2, weight: .heavy, design: .rounded))
                    .transition(.opacity)
            Spacer()
            // here comes a list of previous scores
            Text("\(viewModel.player!.name),  jouw vorige scores..")
                .font(.system(size: Constants.fontSize2, weight: .heavy, design: .rounded))
                    .transition(.opacity)
    
            // scores from the player will come here 
            ForEach(viewModel.player!.scores.prefix(10), id: \.self) {
                    score in
                     Text("\(score)/5")
                        .font(.system(size: 24, weight: .heavy, design: .rounded))
                            .transition(.opacity)
                }

            HStack{
                stopGame
                Spacer()
                deletePlayer
            }
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
        }
    }
    
    func compareScore(for score: Int) -> String {
        switch score {
        case 0:
            return "Je moet nog veel oefenen.."
        case 1:
            return "Niet goed, oefen nog maar een beetje!"
        case 2:
            return "Dit kan beter."
        case 3:
            return "Goed gedaan, je bent er bijna.."
        case 4:
            return "Super! Je wordt nog een echte kampioen!"
        default:
            return "Je bent gewoon een rekenkampioen!"
        }
    }

        
        func compareCashValue(from value: Double) -> String{
            switch value {
            case 50:
                return "50Euro"
            case 20:
                return "20Euro"
            case 10:
                return "10Euro"
            case 5:
                return "5Euro"
            case 2:
                return "2Euro"
            case 1:
                return "1Euro"
            case 0.5:
                return "50Cent"
            case 0.2:
                return "20Cent"
            case 0.1:
                return "10Cent"
            case 0.05:
                return "5Cent"
            case 0.02:
                return "2Cent"
            default:
                return "1Cent"
            }
    }


// Product view
struct ProductView: View{
    
    private let product: CheckoutViewModel.Product
    
    init(show product: CheckoutViewModel.Product){
        self.product = product
    }
    
    var body: some View{
        VStack{
            Text("€ \(product.price, specifier: "%.2f")")
                .font(Font.system(size: Constants.fontSize2, weight: .heavy, design: .rounded))
            Text(product.img)
                .font(Font.system(size: Constants.fontSize))
        }
        .padding()
    }

}

struct dropDelegate : DropDelegate{
    // Bind to the viewModel
    var viewModel: CheckoutViewModel
    //  This function is executed when the user "drops" their object
    func performDrop(info: DropInfo) -> Bool {
        //  Check if there's an array of items with the URI "public.text" in the DropInfo
        if let item = info.itemProviders(for: ["public.text"]).first {
            //  Load the item
            item.loadItem(forTypeIdentifier: "public.text", options: nil) { (text, err) in
                //  Cast NSSecureCoding to Ddata
                if let data = text as? Data {
                    //  Extract string from data
                    let input = String(decoding: data, as: UTF8.self)
                    // main thread
                    DispatchQueue.main.async {
                        viewModel.giveMoney(payed: Double(input) ?? 0)
                        playSound(sound: "cashre", type: "mp3")
                      }
                    
                }
            }
        } else {
            //  If no text was received in our drop, return false
            return false
        }

        return true
    }

}































/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CheckoutViewModel()
        return CheckoutView(viewModel: viewModel)
            .preferredColorScheme(.light)
.previewInterfaceOrientation(.portrait)
    }
}*/
