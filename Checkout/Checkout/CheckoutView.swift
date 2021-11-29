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
            Text(viewModel.getStoreName())
                .font(Font.system(size: Constants.fontSize2))
            Spacer()
            ProductView(show: viewModel.productOnScreen)
            Spacer()
            HStack{
                Text("€ \(viewModel.payed, specifier: "%.2f")")
                    .font(Font.system(size: Constants.fontSize2))
                Image(systemName: "delete.backward")
                    .onTapGesture {
                        viewModel.giveMoney(payed: -viewModel.payed)
                    }
            }
            Spacer()
            moneyView
            Spacer()
            payProduct
            Text("Score: \(viewModel.getScore())")
                .font(Font.system(size: Constants.fontSize2))
        }
        .padding()
        .background(Color.cyan)
        
    }
    
    var payProduct: some View {
        
        Button(
           action: {
               withAnimation{
                   viewModel.pay(for: viewModel.productOnScreen)
               }
        },
           label: {
               Text("Betaal")
                   .foregroundColor(.black)
                   .font(Font.system(size: 32))
        })
        .padding()
        .background(RoundedRectangle(cornerRadius: 15)
        .opacity(0.2))
    }
    
        
    var moneyView: some View {
            
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 50, maximum: 50)),
                            GridItem(.adaptive(minimum: 50, maximum: 50)),
                            GridItem(.adaptive(minimum: 50, maximum: 50)),
                            GridItem(.adaptive(minimum: 50, maximum: 50)),
                          ], content: {
                              ForEach(viewModel.getCash(), id: \.self) { value in
                                 let img: String = compareCashValue(from: value)
                                     Image(img)
                                     .resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(width: 50, height: 50)
                                     .onTapGesture {
                                         withAnimation{
                                             viewModel.giveMoney(payed: value)
                                         }
                                     }
                             }
                          })
                .padding()
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
            Text(product.img)
                .font(Font.system(size: Constants.fontSize))
            Text("€ \(product.price, specifier: "%.2f")")
                .font(Font.system(size: Constants.fontSize2))
            
        }
        .padding()
    }
}






// constants that must be used all the time
struct Constants{
    static let fontSize: CGFloat = 80
    static let fontSize2: CGFloat = 32
    static let cornerRadius: CGFloat = 15
    static let coinWidthHeight: CGFloat = 35
    static let billWidth: CGFloat = 40
    static let billHeight: CGFloat = 25
}































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CheckoutViewModel()
        return CheckoutView(viewModel: viewModel)
            .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
