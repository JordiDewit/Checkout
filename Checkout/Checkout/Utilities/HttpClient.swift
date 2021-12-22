//
//  HttpClient.swift
//  Checkout
//
//  Created by Jordi Dewit on 22/12/2021.
//

import Foundation

enum HTTPMethods: String {
    case POST,GET,DElETE
}

enum MIMEType: String {
    case JSON = "application/json"
}

enum HttpHeaders: String {
    case contenTpe = "Content-Type"
}

enum HttpError: Error {
    case badURL, badResponse, errorDecodingData, invalidURL
}

class HttpClient {
    private init(){ }
    
    static let shared = HttpClient()
    
    // Generic fetch method -> return = generic type "don't care type"
    // ->  return value can be anything
    // ->  can be used for other project in future
    func fetch<T: Codable>(url: URL) async throws -> [T]{
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode([T].self, from: data) else{
            throw HttpError.errorDecodingData
        }
        return object

    }
    
    func createData<T: Codable>(to url: URL, object: T, httpMethod: String) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue(MIMEType.JSON.rawValue, forHTTPHeaderField: HttpHeaders.contenTpe.rawValue)
        request.httpBody = try? JSONEncoder().encode(object)
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
}
