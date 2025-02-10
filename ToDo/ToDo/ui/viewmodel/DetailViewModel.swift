//
//  DetailViewModel.swift
//  ToDo
//
//  Created by Hürmüs Sürücüoğlu on 6.02.2025.
//

import Foundation

class DetailViewModel {

    
    let db:FMDatabase?
    
    init(){
        let veritabaniYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let hedefYol = URL(fileURLWithPath: veritabaniYolu).appendingPathComponent("todolist.sqlite")
        db = FMDatabase(path: hedefYol.path)
    }
    
    func guncelle(id:Int,name:String,status:String)
    {
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE toDos SET name = ?, status = ? WHERE id = ? ", values: [name,status,id])
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
