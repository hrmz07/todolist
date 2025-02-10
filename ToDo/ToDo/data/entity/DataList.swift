//
//  DataList.swift
//  ToDo
//
//  Created by Hürmüs Sürücüoğlu on 6.02.2025.
//

import Foundation

class DataList : Identifiable {
    var id:Int?
    var name:String?
    var status:String?
    
    init(){
        
    }
    
    init(id: Int, name: String, status: String) {
        self.id = id
        self.name = name
        self.status = status
    }
}
