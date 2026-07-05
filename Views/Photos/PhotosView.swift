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
                        systemImage: "photo",
                        description: Text("Add your first photo")
                    )
                } else {

                    ScrollView {
                        LazyVStack(spacing: 12) {

                            ForEach(photos) { photo in
                                if let uiImage = UIImage(data: photo.data) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 250)
                                        .clipped()
                                        .cornerRadius(16)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Photos")
            .toolbar {

                PhotosPicker(
                    selection: $pickerItem,
                    matching: .images
                ) {
                    Image(systemName: "plus")
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
}
