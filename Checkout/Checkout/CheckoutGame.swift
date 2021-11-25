//  Created by Jordi Dewit on 23/11/2021.
//  This will be the model for this checkout game

import Foundation


struct Store{
    
    private(set) var products: Array<Product>
    private(set) var productOnScreen: Product
    
    //INITIALISER
    
    init(numberOfProducts: Int, createImg: (Int) -> String){
        
        products = []
        for i in 1..<numberOfProducts+1{
            let emo: String = createImg(i)
            let price: Double = round((Double.random(in: 1..<1000)))/100
            products.append(Product(id: i, img: emo, price: price))
        }
        productOnScreen = products[0]
        print(products)
        print(productOnScreen)

    }
    
    //FUNCTIONS
    
    
    mutating func getNextProduct(){
        let i = products.firstIndex(where: {
            $0.id == productOnScreen.id
        })!
        
        if i == 0 || i < products.count-1 {
            productOnScreen = products[i+1]
        }else{
            productOnScreen = products[0]
        }
        print(productOnScreen)
    }
    
    //STRUCTS
    struct Product: Identifiable, Equatable{
        
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
}





