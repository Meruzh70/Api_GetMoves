//
//  AuthViewModel.swift
//  Api_GetMoves
//
//  Created by Meruzhan Avetisyan on 12.07.21.
//

import UIKit

class ViewModel: NSObject {

    func getMoves(page: Int, callback: @escaping (_ moveResault: [MoveResalut]?, _ error: String?)-> Void) {
        
        NetworkManager.shared.getMoves(page: page) { respose, error in
            
            if error == nil {
                callback(self.pars(moves: respose!.results), nil)
            } else {
                callback(nil, error)
            }
        }
    }
    
    func pars(moves: [MoveObj]) -> [MoveResalut]  {
        
        var moveList: [MoveResalut] = []
        
        moves.forEach { moveObjt in
            
            let moveResalut = MoveResalut(moveObj: moveObjt)
            
            moveList.append(moveResalut)
        }
        return moveList
    }
}
