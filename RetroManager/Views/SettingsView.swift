import SwiftUI

struct SettingsView: View {
    
    @State private var isOn = false
    
    var body: some View {
        Form {
            Section("Account") {
                Text("Email")
                Text("Phone Number")
            }
            
            Section("Settings") {
                Text("Phone Number")
                Toggle("Push Notifications", isOn: $isOn)
            }
        }
        .formStyle(.grouped)
    }
}

#Preview {
    SettingsView()
}
