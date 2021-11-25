//  Created by Jordi Dewit on 23/11/2021.
//  This is the viewmodel for checkout game

import Foundation
import SwiftUI


class CheckoutViewModel: ObservableObject
{
    // model with which we communicate
    @Published private var model = buildStore()
    typealias Product = Store.Product

    // computed property with products
    var products: Array<Store.Product>{
      return model.products
    }
    
    var productOnScreen: Product {
        return model.productOnScreen
    }
    
    
    static func buildStore() -> Store {
        
      return Store(numberOfProducts: 5, createImg: { index in
            KindsOfProducts.butcher[index]
        })
        
    }
    
    func getNextProduct(){
        model.getNextProduct()
    }
 
    
    // different kinds of products depending of kind of store the user has chosen
    struct KindsOfProducts {
        static let bakery       = ["🥖","🍞","🥯","🥐","🧇","🥞","🥨","🥧","🍰","🧁","🍪","🍩"]
        static let butcher      = ["🥩","🥓","🍖","🍗","🦴","🍔"]
        static let veggieFarmer = ["🥦", "🥬", "🥕", "🫑","🧄", "🧅", "🍠","🌽", "🍆"]
        static let fruitShop    = ["🍏","🍎","🍊","🍋","🍉","🍇","🍓","🫐","🍌","🍑"]
        static let toyStore     = ["🚗","🏎","🛴","🚲","🚜","🚎","✈️","🛶","🚁"]
        static let sportStore   = ["⚽️","🏀","🏈","🏓","🪃","🥋","⛸","🛼","🤿","🥅"]
    }
    
}






