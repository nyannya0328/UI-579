//
//  SideBar.swift
//  UI-579
//
//  Created by nyannyan0328 on 2022/06/06.
//

import SwiftUI

struct SideBar: View {
    var props : Properties
    @Binding var curretntTab : Tab
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing:20){
                
                HStack{
                    
                    Image("icloud")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                    
                    
                    Text("iClound")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                
                
                Rectangle()
                    .fill(.white.opacity(0.3))
                    .frame(height: 1)
                    .padding(.horizontal,-15)
                
                
                ForEach(Tab.allCases,id:\.rawValue){tab in
                    
                    Button {
                        withAnimation{curretntTab = tab}
                    } label: {
                        
                        HStack{
                            
                            Image(tab.rawValue)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            
                            
                            Text(tab.rawValue)
                                .fontWeight(.light)
                        }
                        .foregroundColor(curretntTab == tab ? .white : .gray.opacity(0.5))
                          .frame(maxWidth: .infinity,alignment: .leading)
                    }

                    
                }
                
            }
            .padding(15)
            
        }
        .frame(width: 230)
         .background{
        
             Color("Overlay").ignoresSafeArea()
        }
        
    }
}

struct SideBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
