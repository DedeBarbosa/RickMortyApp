//
//  NetworkService.swift
//  RickMortyApp
//
//  Created by Dmitry Pavlov on 13.11.2019.
//  Copyright © 2019 Dmitry Pavlov. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol{
    func fetchMovieList(completion: @escaping (_ characters: CharactersList)->())
    func getImage(by path: String, completion: @escaping(_ data: Data)->())
}

class NetworkService: NetworkServiceProtocol{

    static let shared = NetworkService()
    static var imageDictionary = [String : Data]()
    
    func fetchMovieList(completion: @escaping (_ characters: CharactersList)->()) {
           let host = "https://rickandmortyapi.com/api/character/"
           
        guard let url = URL(string: host) else {return}
           URLSession.shared.dataTask(with: url){ (data, _, _) in
               guard let data = data else {return}
           
               do {
                   let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                   let characters = try decoder.decode(CharactersList.self, from: data)
                   completion(characters)
               } catch let error {
                   print("Error serialization json", error)
               }
           }.resume()
       }
    
    func getImage(by path: String?) -> Data?{
        guard let path = path else {return nil}
        if NetworkService.imageDictionary.keys.contains(path){
            return NetworkService.imageDictionary[path]
        }
        guard let url = URL(string: path) else {return nil}
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        NetworkService.imageDictionary[path] = imageData
        return imageData
    }
    
    func getImage(by path: String, completion: @escaping (_ data: Data)->()) {
           guard let url = URL(string: path) else {return}
            URLSession.shared.dataTask(with: url){ (data, _, _) in
                guard let data = data else {return}
                DispatchQueue.main.async {
                    completion(data)
                }
                    
            }.resume()
       }
    
}

