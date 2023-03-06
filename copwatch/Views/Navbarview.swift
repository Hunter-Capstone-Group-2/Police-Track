//
//  TabView.swift
//  copwatch
//
//  Created by Steve Roy on 3/5/23.
//

import SwiftUI

struct Navbarview: View {
    
    init() {
        // Set the colour of the unselected tabBar items
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }
    
    var body: some View {
        TabView {

            Mapview()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        
        }
        .tint(Color.blue) // The color of the tabBar item that is selected
    }
}
struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        Navbarview()
    }
}
