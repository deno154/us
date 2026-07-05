import SwiftUI

struct NotesView: View {

    var body: some View {
        NavigationStack {

            ContentUnavailableView(
                "No Notes",
                systemImage: "note.text",
                description: Text("Create your first note.")
            )
            .navigationTitle("Notes")
        }
    }
}

#Preview {
    NotesView()
}
