import SwiftUI

struct RootTabView: View {

    var body: some View {
        TabView {

            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            PhotosView()
                .tabItem {
                    Label("Photos", systemImage: "photo.on.rectangle")
                }

            NotesView()
                .tabItem {
                    Label("Notes", systemImage: "note.text")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    RootTabView()
}
