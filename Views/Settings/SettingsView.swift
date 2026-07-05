import SwiftUI

struct SettingsView: View {

    var body: some View {
        NavigationStack {

            List {

                Section("Appearance") {

                    Text("System")

                }

            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
