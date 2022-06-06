//
//  MainView.swift
//  UI-579
//
//  Created by nyannyan0328 on 2022/06/06.
//

import SwiftUI

struct MainView: View {
    @State var currentTab : Tab = .dashboard
    @State var showSlder : Bool = false
    var body: some View {
        ResponceView { props in
            
            HStack(spacing:0){
                
                if props.isIpad && !props.isSprit{
                
                SideBar(props: props, curretntTab: $currentTab)
                    
                    
                }
                
                DashBoadView(props: props, showSlder: $showSlder)
                
                
            }
            .overlay {
                
                ZStack(alignment: .leading) {
                    
                    Color.black
                        .opacity(showSlder ? 0.35 : 0)
                        .ignoresSafeArea()
                        .onTapGesture {
                            
                            withAnimation(.easeOut){
                                
                                showSlder = false
                                
                            }
                        }
                    
                    if showSlder{
                        
                        
                        SideBar(props: props, curretntTab: $currentTab)
                            .transition(.move(edge: .leading))
                        
                        
                    }
                }
            }
        }
    
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
