//
//  Authview.swift
//  copwatch
//
//  Created by Ramy on 2/23/23.
//

import SwiftUI

struct Authview: View {
    @State private var currentViewShowing: String = "login" //logging or signing up
    
    
    var body: some View {
        
        if (currentViewShowing == "login") {
            Loginview(currentShowingView: $currentViewShowing)
                .preferredColorScheme(.light)
            
            
        } else {
            Signupview (currentShowingView:  $currentViewShowing)
                .preferredColorScheme(.dark)
        }
        
        
    }
}

struct Authview_Previews: PreviewProvider {
    static var previews: some View {
        Authview()
    }
}
