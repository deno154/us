import SwiftUI
import SwiftData
import PhotosUI

struct PhotosView: View {

    @Environment(\.modelContext) private var context
    @Query(sort: \PhotoModel.dateAdded, order: .reverse) private var photos: [PhotoModel]

    @State private var pickerItem: PhotosPickerItem?

    var body: some View {

        NavigationStack {

            ScrollView {

                if photos.isEmpty {

                    ContentUnavailableView(
                        "No Photos",
                        systemImage: "photo.on.rectangle",
                        description: Text("Add your first photo")
                    )
                    .padding(.top, 80)

                } else {

                    LazyVStack(spacing: 16) {

                        ForEach(photos) { photo in

                            if let uiImage = UIImage(data: photo.data) {

                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 260)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .clipped()
                                    .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 6)
                                    .padding(.horizontal)
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) {
                                            context.delete(photo)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.top, 12)
                }
            }
            .navigationTitle("Photos")
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(selection: $pickerItem, matching: .images) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onChange(of: pickerItem) { _, newItem in
                Task {
                    guard let data = try? await newItem?.loadTransferable(type: Data.self) else { return }
                    context.insert(PhotoModel(data: data))
                }
            }
        }
    }
}

#Preview {
    PhotosView()
}
