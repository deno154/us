import SwiftUI
import SwiftData

struct PhotoCard: View {

    @Environment(\.modelContext) private var context

    let photo: PhotoModel

    var body: some View {

        if let uiImage = UIImage(data: photo.data) {

            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(height: 260)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .clipped()
                .padding(.horizontal)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {

                    Button(role: .destructive) {
                        delete()
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
        }
    }

    private func delete() {
        context.delete(photo)
    }
}
