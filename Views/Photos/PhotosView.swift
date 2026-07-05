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

                        ForEach(photos, id: \.persistentModelID) { photo in

                            PhotoCard(photo: photo)
                                .transition(.opacity)
                        }
                    }
                    .padding(.top, 12)
                    .animation(.easeInOut, value: photos.count)
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

                    let photo = PhotoModel(data: data)
                    context.insert(photo)
                }
            }
        }
    }
}

#Preview {
    PhotosView()
}
