//
//  moveResalut.swift
//  Api_GetMoves
//
//  Created by Meruzhan Avetisyan on 12.07.21.
//

import UIKit

class MoveResalut: NSObject {

    var adult: Bool = false
    var backdrop_path: String = ""
    var genre_ids: [Int] = []
    var id: Int = 0
    var original_language: String = ""
    var original_title: String = ""
    var overview: String = ""
    var popularity: Double = 0.0
    var poster_path: String = ""
    var release_date: String = ""
    var title: String = ""
    var video: Bool = false
    var vote_average: Double = 0.0
    var vote_count: Int = 0
    
    init(moveObj: MoveObj) {
        
        self.adult = moveObj.adult
        self.backdrop_path = moveObj.backdrop_path ?? ""
        self.genre_ids = moveObj.genre_ids
        self.id = moveObj.id
        self.original_language = moveObj.original_language
        self.original_title = moveObj.original_title
        self.overview = moveObj.overview
        self.popularity = moveObj.popularity
        self.poster_path = moveObj.poster_path
        self.release_date = moveObj.release_date
        self.title = moveObj.title
        self.video = moveObj.video
        self.vote_average = moveObj.vote_average
        self.vote_count = moveObj.vote_count
        
    }
}
