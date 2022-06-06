//
//  ContentView.swift
//  UI-579
//
//  Created by nyannyan0328 on 2022/06/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
