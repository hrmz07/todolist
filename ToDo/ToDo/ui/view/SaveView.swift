//
//  SaveView.swift
//  ToDo
//
//  Created by Hürmüs Sürücüoğlu on 6.02.2025.
//

import SwiftUI

struct SaveView: View {
    @State private var tfName = ""
    @State private var tfStatus = ""
    
    var viewModel = SaveViewModel()
    
    
    var body: some View {
        ZStack {
            Color("MainColor")
                .ignoresSafeArea()
            VStack(spacing: 100){
                TextField("Yapılacak",text: $tfName)
                    .foregroundStyle(.black)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                
                Toggle("İşlem Tamamlandı mı?", isOn: Binding(
                    get:{tfStatus == "1"},
                    set:{tfStatus = $0 ? "1" : "0"}
                ))
                .padding()
                

                Button {
                    viewModel.kaydet(name: tfName, status: tfStatus)
                } label: {
                    Text("Kaydet")
                        .padding()
                        .padding(.horizontal, 20)
                        .foregroundStyle(Color("MainColor"))
                        .bold()
                        .background(.white)
                }
                
            }.navigationTitle("To Do Kayıt")
        }
    }
}

#Preview {
    SaveView()
}
