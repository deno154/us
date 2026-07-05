import SwiftUI
import SwiftData

struct NotesView: View {

    @Environment(\.modelContext) private var context
    @Query(sort: \NoteModel.date, order: .reverse) private var notes: [NoteModel]

    @State private var newNoteText: String = ""

    var body: some View {

        NavigationStack {

            VStack(spacing: 12) {

                // INPUT
                HStack {

                    TextField("New note...", text: $newNoteText)
                        .textFieldStyle(.roundedBorder)

                    Button {
                        addNote()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .disabled(newNoteText.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding()

                // LIST
                if notes.isEmpty {

                    Spacer()

                    ContentUnavailableView(
                        "No Notes",
                        systemImage: "note.text",
                        description: Text("Write something about Arina")
                    )

                    Spacer()

                } else {

                    List {

                        ForEach(notes, id: \.id) { note in

                            VStack(alignment: .leading, spacing: 6) {

                                Text(note.text)
                                    .font(.body)

                                Text(note.date, style: .date)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    context.delete(note)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Notes")
        }
    }

    private func addNote() {

        let trimmed = newNoteText.trimmingCharacters(in: .whitespaces)

        guard !trimmed.isEmpty else { return }

        let note = NoteModel(text: trimmed)
        context.insert(note)

        newNoteText = ""
    }
}

#Preview {
    NotesView()
}
