//
//  SaveViewModel.swift
//  ToDo
//
//  Created by Hürmüs Sürücüoğlu on 6.02.2025.
//

import Foundation

class SaveViewModel {
    let db:FMDatabase?
    
    init(){
        let veritabaniYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let hedefYol = URL(fileURLWithPath: veritabaniYolu).appendingPathComponent("todolist.sqlite")
        db = FMDatabase(path: hedefYol.path)
    }
    
    func kaydet(name:String,status:String){
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO toDos (name,status) VALUES (?,?)", values: [name,status])
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
