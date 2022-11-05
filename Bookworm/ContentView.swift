//
//  ContentView.swift
//  Bookworm
//
//  Created by Sebastien REMY on 05/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationSplitView {
            ListingView()
                .frame(minWidth: 250)
        } detail: {
            Text("Please select a review")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
