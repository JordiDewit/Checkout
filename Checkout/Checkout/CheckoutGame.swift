//  Created by Jordi Dewit on 23/11/2021.
//  This will be the model for this checkout game

import Foundation


struct Store<ProductImg> {
    
  private(set) var products: [Product]
    
    init(numberOfProducts: Int, createImg: (Int) -> ProductImg ){
        products = []
        
        for i in 0..<numberOfProducts{
            var productImg = createImg(i)
            products.append(Product(id: i, img: ProductImg, price: generatePrice()))
        }
    }
    
    // Generate a price for a product
    private func generatePrice() -> Double{
        var min = 1
        var max = 10
        return Double.random * (Double(max - min)) + Double(min)
    }
}



class Product : Identifiable{
    
    let id: Int
    let img: String
    let price: Double
    
    //initialising from a product instance
    init(id: Int, img: String, price: Double){
        self.id    = id
        self.img   = img
        self.price = price
    }
    
}



class Player{
    let name: String
    let score: Int
    
    init(name: String){
        self.name = name
        score     = 0
    }
}
