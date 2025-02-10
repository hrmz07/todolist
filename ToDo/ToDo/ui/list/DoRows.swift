//
//  DoRows.swift
//  ToDo
//
//  Created by Hürmüs Sürücüoğlu on 7.02.2025.
//

import SwiftUI

struct DoRows: View {
    var list = DataList()
    
    var body: some View {
        HStack(spacing: 16){
            
            //Text((list.status)!).font(.system(size: 20)).foregroundStyle(.gray)
            ZStack {
                Rectangle()
                    .fill(.white)
                    .frame(width: 30, height: 30, alignment: .center)
                Image(systemName: list.status! == "1" ? "checkmark.square.fill" : "xmark.square.fill").foregroundColor(list.status! == "1" ? .green : .red).font(.system(size: 30))
            }
            Text(list.name!)
                .foregroundStyle(Color("TextColor1"))
                .font(.system(size: 25))
            
        }
    }
}

#Preview {
    DoRows()
}
