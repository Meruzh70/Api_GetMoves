//
//  NetworkManager.swift
//  Api_GetMoves
//
//  Created by Meruzhan Avetisyan on 06.07.21.
//

import UIKit
import Alamofire

enum BASE_URL: String {
    
    case dev = "https://dev-api.themoviedb.org"
    case prod = "https://api.themoviedb.org"
}
enum Base_IMAGE_URL: String {
    case dev = "https://dev_image.tmdb.org/t/p/w500"
    case prod = "https://image.tmdb.org/t/p/w500"
}


class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    var isDev = false
    
    var BASEURL: String {
        if isDev {
            return BASE_URL.dev.rawValue
        } else {
            return BASE_URL.prod.rawValue
        }
    }

    func getMoves(page: Int, callback: @escaping (_ moviesResponse: MoviesResponse?, _ error: String?) -> Void) {
        
        var params: Parameters = [String : Any]()
        params = ["page" : page, "language" : "en-US", "api_key" : "ec5cd774856614504f1a84ab00e5a6cf"]
        AF.request("\(BASEURL)/3/movie/popular", method: .get, parameters: params).responseJSON { respone in
            
            print(respone)
            
            guard let data = respone.data else {
                
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let moviesRespone = try decoder.decode(MoviesResponse.self, from: data)
                print(moviesRespone.results)
                callback(moviesRespone, nil)
                
            } catch {
                print("Failed to decode JSN", error.localizedDescription)
                callback(nil, error.localizedDescription)
            }
            
        }
    }
}


struct MoviesResponse: Codable {
    var page: Int
    var results: [MoveObj]
    var total_pages: Int
    var total_results: Int
    
}

struct MoveObj: Codable {
    
    var adult: Bool
    var backdrop_path: String?
    var genre_ids: [Int]
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Double
    var poster_path: String
    var release_date: String
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Int

}
