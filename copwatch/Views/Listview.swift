//
//  Listview.swift
//  copwatch
//
//  Created by Ramy on 2/26/23.
//

import SwiftUI
import Firebase

struct Listview: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Text ("List items will go here")
        }
        .listStyle(.plain)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Sign out") {
                    do {
                        try Auth.auth().signOut()
                        print (" Log out Successfull!")
                        dismiss()
                    } catch {
                        print ("could not sign out")
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //add item code
                } label : {
                    Image(systemName: "plus")
                }
        }
        }
    }
}

struct Listview_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Listview()
        }
        
    }
}
