//
//  File.swift
//  Checkout
//
//  Created by Jordi Dewit on 20/12/2021.
//

import Foundation

class StartViewModel: ObservableObject{
    @Published var storeOption: String = "Bakkerij"
    @Published var level: String = "Makkelijk"
    @Published var playerName: String = ""
    var players: Array<Player>?
    var currentPlayer: Player?
    
    
    func getPlayers() async throws {
        let urlString = APIConstants.basicURL + Endpoints.players
        
        // make sure URL exists
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let playerResponse: [Player] = try await HttpClient.shared.fetch(url: url)
        
        // must happen on main thread
        DispatchQueue.main.async {
            self.players = playerResponse
        }
    }
    
    func checkIfPlayerExist(){
        let sameNames = players?.filter{
            $0.name == self.playerName
        }
        
        if sameNames?.count ?? 0 > 0{
            self.currentPlayer = players?.first(where: { p in
                p.name == self.playerName
            } )
        }else{
            Task{
                do{
                    try await createPlayer(name: self.playerName)
                }catch{
                    print("Error: \(error)")
                }
            }
        }
    }
    
    //create player if not exist
    func createPlayer(name: String) async throws {
        let urlString = APIConstants.basicURL + Endpoints.players
        
        // make sure URL exists
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let player = Player(id: nil, name: name, scores: [])
        
        let response: Player = try await HttpClient.shared.createPlayer(to: url, object: player, httpMethod: HTTPMethods.POST.rawValue)

        DispatchQueue.main.async {
            self.currentPlayer = response
        }
    }
  
   
}


