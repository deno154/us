import SwiftUI

struct SettingsView: View {

    @AppStorage("app_theme") private var theme: String = AppTheme.system.rawValue

    var body: some View {

        NavigationStack {

            List {

                Section("Appearance") {

                    Picker("Theme", selection: $theme) {

                        Text("System").tag(AppTheme.system.rawValue)
                        Text("Dark").tag(AppTheme.dark.rawValue)
                        Text("Light").tag(AppTheme.light.rawValue)
                    }
                }

                Section("About") {
                    Text("Us — Arina relationship tracker")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
