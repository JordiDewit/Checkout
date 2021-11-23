//  Created by Jordi Dewit on 23/11/2021.
//  This is the main view of the checkout game
//  This view will show a store, product and the currency where the
//  user has to pay with to buy the product


import SwiftUI

struct CheckoutView: View {
    var body: some View {
        ProductView()
    }
}

// This is the view for a product + price
struct ProductView: View {
    var body: some View {
        VStack{
            Text("🥐")
                .font(.system(size: ViewConstants.fontsize))
            Text("prijs")
                .font(.system(size: ViewConstants.fontsize - 30))
        }
    }
}

struct ViewConstants {
    static let fontsize: CGFloat = 70
}



























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .preferredColorScheme(.dark)
    }
}
