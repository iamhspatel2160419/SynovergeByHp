//
//  Validatable.swift
//  SynovergeByHp
//
//  Created by Apple on 21/12/20.
//

import Foundation

protocol Validatable {
    func validate() -> (Bool,String)
}
