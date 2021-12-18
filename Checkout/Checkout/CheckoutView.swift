//  Created by Jordi Dewit on 23/11/2021.
//  This is the main view of the checkout game
//  This view will show a store, product and the currency where the
//  user has to pay with to buy the product


import SwiftUI

// main view
struct CheckoutView: View {
    
    // viewmodel dependency
    @ObservedObject var viewModel: CheckoutViewModel
    
    
    var body: some View {
       
        VStack{
            HStack{
                Text(viewModel.getStoreName().uppercased())
                    .font(.system(size: Constants.fontSize2, weight: .heavy, design: .rounded))
                        .transition(.opacity)
                Spacer()
                Text("Score: \(viewModel.getScore())")
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
        }
        .padding()
        .background(
            Image("store")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .opacity(0.5)
            )
    }
 
    // the cash register which receives the money
    var cashRegister: some View {
        Image("cashRegister")
            .resizable()
            .frame(width: 180, height: 180)
            //.onDrop(of: [String], delegate: viewModel.giveMoney(payed: value))
    }
    // button to quit the game
    var stopGame: some View {
        Button(
           action: {
               //intentionally still blank
        },
           label: {
               Text("Stop")
                   .font(Font.system(size: 26, weight: .heavy, design: .rounded))
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
               }
        },
           label: {
               Text("Betaal")
                   .font(Font.system(size: 26, weight: .heavy, design: .rounded))
        })
        .padding()
        .foregroundColor(.black)
        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .top, endPoint: .bottom))
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
                                return NSItemProvider(object: img as NSString)
                            }
                            /*.onTapGesture {
                                withAnimation{
                                    viewModel.giveMoney(payed: value)
                                }
                            }*/
                    }else{
                        let img: String = compareCashValue(from: value)
                        Image(img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .overlay(RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.black, lineWidth: 3))
                            .shadow(radius: 50)
                            .onTapGesture {
                                withAnimation{
                                    viewModel.giveMoney(payed: value)
                                }
                            }
                    }
                }
        }
        .padding(.all, -11.0)
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






// constants that must be used all the time
struct Constants{
    static let fontSize: CGFloat = 120
    static let fontSize2: CGFloat = 36
}































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CheckoutViewModel()
        return CheckoutView(viewModel: viewModel)
            .preferredColorScheme(.light)
.previewInterfaceOrientation(.portrait)
    }
}
