import SwiftUI
import SwiftData
import PhotosUI

struct PhotosView: View {

    @Environment(\.modelContext) private var context
    @Query(sort: \PhotoModel.dateAdded, order: .reverse) private var photos: [PhotoModel]

    @State private var pickerItem: PhotosPickerItem?

    var body: some View {

        NavigationStack {

            VStack {

                if photos.isEmpty {

                    ContentUnavailableView(
                        "No Photos",
                        systemImage: "photo.on.rectangle",
                        description: Text("Add your first photo")
                    )

                } else {

                    List {

                        ForEach(photos) { photo in

                            if let uiImage = UIImage(data: photo.data) {

                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 240)
                                    .clipped()
                                    .cornerRadius(16)
                                    .listRowInsets(EdgeInsets())
                            }
                        }
                        .onDelete(perform: deletePhotos)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Photos")
            .toolbar {

                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(selection: $pickerItem, matching: .images) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onChange(of: pickerItem) { _, newItem in
                Task {
                    guard let data = try? await newItem?.loadTransferable(type: Data.self) else { return }
                    let photo = PhotoModel(data: data)
                    context.insert(photo)
                }
            }
        }
    }

    // MARK: - Delete

    private func deletePhotos(at offsets: IndexSet) {
        for index in offsets {
            let photo = photos[index]
            context.delete(photo)
        }
    }
}

#Preview {
    PhotosView()
}
