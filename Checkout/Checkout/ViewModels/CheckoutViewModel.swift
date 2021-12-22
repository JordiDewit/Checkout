//  Created by Jordi Dewit on 23/11/2021.
//  This is the viewmodel for checkout game

import Foundation
import SwiftUI


class CheckoutViewModel: ObservableObject
{
    // model with which we communicate
    @Published private var model = buildStore()
    @Published var players = [Player]()
    var playerID: UUID?
    
    typealias Product = Store.Product

    // computed property with products
    var products: Array<Store.Product>{
      return model.products
    }
    
    var productOnScreen: Product {
        return model.productOnScreen
    }
    
    var payed: Double {
        return model.payed
    }
    
    // building the store (game)
    static func buildStore() -> Store {
        return Store()
    }
    func setNameAndLevel(store: String, level: Int){
        model.setNameAndLevel(storeOption: store, level: level)
    }
    
    // getter for the storename
    func getStoreName() -> String{
        return model.name!
    }
    
    // get cash (levels must be still implemented)
    func getCash() -> Array<Double>{
        return model.getCash()
    }
    
    // getter for the next product
    func getNextProduct(){
        model.getNextProduct()
    }
    // getter to collect te money
    func giveMoney(payed value: Double){
        model.giveMoney(payed: value)
    }
    
    // function to pay the product
    func pay(for product: Product){
        model.pay(payed: payed, for: product)
    }
    // getter for score
    func getScore() -> Int{
        return model.score
    }
    // check if it is the end of the game
    func isOver() -> Bool {
        return model.endOfGame
    }
    func createPlayer(name: String) async throws {
        let urlString = APIConstants.basicURL + Endpoints.players
        
        // make sure URL exists
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let player = Player(id: nil, name: name, scores: [])
        
        try await HttpClient.shared.createData(to: url, object: player, httpMethod: HTTPMethods.POST.rawValue)
    }
    
    func checkIfPlayerExists(){
        // must be implemented
    }
    
    func getPlayers() async throws {
        let urlString = APIConstants.basicURL + Endpoints.players
        
        // make sure URL exists
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let songResponse: [Player] = try await HttpClient.shared.fetch(url: url)
        
        // must happen on main thread
        DispatchQueue.main.async {
            self.players = songResponse
        }
    }
    
}






