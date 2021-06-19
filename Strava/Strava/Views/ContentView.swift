//
//  ContentView.swift
//  Strava
//
//  Created by Finnis, Jack (PGW) on 12/05/2021.
//

import SwiftUI

struct ContentView: View {
    let stravaAuthenticator = StravaAuthenticator()
    
    var body: some View {
        Button(action: {
            stravaAuthenticator.presentStravaAuthentication()
        }, label: {
            Text("Connect to Strava")
        })
    }
}
