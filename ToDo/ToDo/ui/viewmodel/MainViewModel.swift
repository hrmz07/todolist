//
//  MainViewModel.swift
//  ToDo
//
//  Created by Hürmüs Sürücüoğlu on 6.02.2025.
//

import Foundation

class MainViewModel: ObservableObject{
    @Published var dataListe = [DataList]()
    
    let db:FMDatabase?
    
    init(){
        let veritabaniYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let hedefYol = URL(fileURLWithPath: veritabaniYolu).appendingPathComponent("todolist.sqlite")
        db = FMDatabase(path: hedefYol.path)
    }
    
    func kisileriYukle(){
        db?.open()
        
        var liste = [DataList]()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM toDos", values: nil)
            
            while result.next() {
                let id = Int(result.string(forColumn: "id"))!
                let name = result.string(forColumn: "name")!
                let status = (result.string(forColumn: "status"))!
                
                let lists = DataList(id: id, name: name, status: status)
                liste.append(lists)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        dataListe = liste
        
        db?.close()
    }
    
    func ara(aramaKelimesi:String){
        db?.open()
        
        var liste = [DataList]()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM toDos WHERE name like ?", values: ["%\(aramaKelimesi)%"])
            
            while result.next() {
                let id = Int(result.string(forColumn: "id"))!
                let name = result.string(forColumn: "name")!
                let status = result.string(forColumn: "status")!
                
                let lists = DataList(id: id, name: name, status: status)
                liste.append(lists)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        dataListe = liste
        
        db?.close()
    }
    
    func sil(id:Int){
        db?.open()
        
        do {
            try db!.executeUpdate("DELETE FROM toDos WHERE id = ?", values: [id])
            //kisileriYukle()
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
