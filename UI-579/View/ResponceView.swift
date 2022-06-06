//
//  ResponceView.swift
//  UI-579
//
//  Created by nyannyan0328 on 2022/06/06.
//

import SwiftUI

struct ResponceView<Content : View>: View {
    
    var content : (Properties) -> Content
    var body: some View {
        GeometryReader{proxy in
            
             let size = proxy.size
            let isLandScape = (size.width > size.height)
             let isPad = UIDevice.current.userInterfaceIdiom == .pad
            content(Properties(isLandScape: isLandScape, isIpad: isPad, isSprit: isSprit(), size: size))
                .frame(width: size.width, height: size.height)
                .onAppear {
                    
                    
                    updateNotification(fraction: isLandScape && isSprit() ? 0.3 : 0.5)
                    
                }
                .onChange(of: isLandScape) { newValue in
                    
                    updateNotification(fraction: isLandScape && isSprit() ? 0.3 : 0.5)
                    
                }
            
            
        }
    }
    func updateNotification(fraction : Double){
        
        NotificationCenter.default.post(name: Notification.Name( "UPDATENOTIFICATION"), object: nil,userInfo: [
        
            "Fraction" : fraction
        
        ])
        
    }
    func isSprit()->Bool{
        
        guard let screnn = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            
            return false
        }
        
        return screnn.windows.first?.frame.size != UIScreen.main.bounds.size
    }
}

struct Properties{
    
    var isLandScape : Bool
    var isIpad : Bool
    var isSprit : Bool
    var size : CGSize
    
}
