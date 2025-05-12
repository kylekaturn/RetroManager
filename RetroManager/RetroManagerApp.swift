//
//  RetroManagerApp.swift
//  RetroManager
//
//  Created by Daewoo Kim on 5/11/25.
//

import SwiftUI

@main
struct RetroManagerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.commands{
            CommandGroup(after: .appInfo){
                Button("Custom Command"){
                    print("Custom Command")
                }
            }
        }
        
        Settings{
            SettingsView().frame(width: 300, height: 300)
        }
    }
}
