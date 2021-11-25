//  Created by Jordi Dewit on 23/11/2021.
//  This is the main view of the checkout game
//  This view will show a store, product and the currency where the
//  user has to pay with to buy the product


import SwiftUI

struct CheckoutView: View {
    
    // viewmodel dependency
    @ObservedObject var viewModel: CheckoutViewModel
    
    
    var body: some View {
        VStack{
            Text("CHECKOUT")
                .font(Font.system(size: Constants.fontSize2))
                .padding()
            Spacer()
            ProductView(show: viewModel.productOnScreen)
            nextProduct
        }
        .padding()
        
    }
    
    var nextProduct: some View {
        Button("Next"){
            viewModel.getNextProduct()
        }
    }
    
}

struct ProductView: View{
    
    private let product: CheckoutViewModel.Product
    
    init(show product: CheckoutViewModel.Product){
        self.product = product
    }
    
    var body: some View{
        VStack{
            Text(product.img)
                .font(Font.system(size: Constants.fontSize))
            Text("\(product.price, specifier: "%.2f")")
                .font(Font.system(size: Constants.fontSize2))
            
        }
        .padding()
        
    }
}


struct Constants{
    static let fontSize: CGFloat = 100
    static let fontSize2: CGFloat = 32
}































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CheckoutViewModel()
        return CheckoutView(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
