//
//  ContentView.swift
//  ToDo
//
//  Created by Hürmüs Sürücüoğlu on 6.02.2025.
//

import SwiftUI

struct MainView: View {
    init() {
        let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor (named: "MainColor")
        
        let textColor =  UIColor (named: "TextColor1") ?? .white
            appearance.titleTextAttributes = [.foregroundColor : textColor]
            appearance.largeTitleTextAttributes = [.foregroundColor : textColor]
        
        
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance

        }
    
    @State private var aramaKelimesi = ""
    
    @ObservedObject private var viewModel = MainViewModel()
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack{
            ZStack {

                    
                Color("MainColor")
                    .ignoresSafeArea()
                
                VStack(alignment:.leading){

                    Text("A simple SwiftUI Todo List App")
                        .foregroundStyle(.white)
                        .padding()
                    LazyVGrid(columns: [GridItem(.flexible(minimum: 300)),GridItem(.flexible())],  alignment: .leading, spacing: 20) {
                        ForEach(viewModel.dataListe){ kisi in
                            NavigationLink(destination: DetailView(dataList: kisi)){
                                DoRows(list: kisi)
                                    
                            }
                            
                            Button {
                                        showAlert = true
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundStyle(Color("TextColor1"))

                                    }
                                    .alert("Uyarı", isPresented: $showAlert) {
                                        Button("Tamam", role: .destructive) {
                                            viewModel.sil(id: kisi.id!)
                                            viewModel.kisileriYukle()
                                            //print("Sil Tıklandı \(kisi.id)")
                                        }
                                        Button("İptal", role: .cancel) { }
                                    } message: {
                                        Text("Silme işlemini onaylıyor musunuz?")
                                    }
                            
//                            Image(systemName: "trash")
//                                .onTapGesture {
//                                  
//                                    viewModel.sil(id: kisi.id!)
//                                    viewModel.kisileriYukle()
//                                    print("Sil Tıklandı \(kisi.id)")
//                                    
//                                    
//                                }
                        }//.onDelete(perform: sil)
                    }
                    .padding()
                    Spacer()
                }
                
            }
            .navigationTitle("Todo List")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink(destination: SaveView()){
                            Image(systemName: "plus")
                                .foregroundStyle(Color("TextColor1"))
                        }
                    }
                }.onAppear{
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white
                    veritabaniKopyala()
                    viewModel.kisileriYukle()
                }
                
        }
        .searchable(text: $aramaKelimesi,prompt: "Ara")
            //.foregroundColor(.white)
            .onChange(of: aramaKelimesi){ _ , s in
                viewModel.ara(aramaKelimesi: s)
            }
    }
    
    func sil(at offsets:IndexSet){
        let kisi = viewModel.dataListe[offsets.first!]
        viewModel.sil(id: kisi.id!)
   }
    
    
    func veritabaniKopyala(){
            let bundle = Bundle.main.path(forResource: "todolist", ofType: ".sqlite")
            
            let veritabaniYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            let hedefYol = URL(fileURLWithPath: veritabaniYolu).appendingPathComponent("todolist.sqlite")
            
            let fm = FileManager.default
            
            if fm.fileExists(atPath: hedefYol.path) {
                print("Veritabanı daha önce kopyalanmış.")
            }else{
                do{
                    try fm.copyItem(atPath: bundle!, toPath: hedefYol.path)
                }catch{
                    print(error.localizedDescription)
                }
            }
    }
}

#Preview {
    MainView()
}
