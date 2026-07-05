import SwiftUI
import SwiftData

struct HomeView: View {

    @Query(sort: \PhotoModel.dateAdded, order: .reverse) private var photos: [PhotoModel]

    @State private var index: Int = 0

    private let startDate = Calendar.current.date(from: DateComponents(year: 2025, month: 9, day: 26))!

    private var days: Int {
        Calendar.current.dateComponents([.day], from: startDate, to: Date()).day ?? 0
    }

    private var currentPhoto: PhotoModel? {
        guard !photos.isEmpty else { return nil }
        return photos[index % photos.count]
    }

    var body: some View {

        NavigationStack {

            ZStack {

                // BACKGROUND
                if let photo = currentPhoto,
                   let uiImage = UIImage(data: photo.data) {

                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .blur(radius: 50)
                        .opacity(0.6)
                        .animation(.easeInOut(duration: 0.5), value: index)
                } else {
                    Color.black.ignoresSafeArea()
                }

                VStack(spacing: 24) {

                    Spacer()

                    // MAIN PHOTO
                    if let photo = currentPhoto,
                       let uiImage = UIImage(data: photo.data) {

                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 280, height: 280)
                            .clipShape(RoundedRectangle(cornerRadius: 28))
                            .shadow(color: .black.opacity(0.4), radius: 20)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    index = (index + 1) % photos.count
                                }
                            }
                    }

                    // GLASS INFO CARD
                    GlassCard {

                        VStack(spacing: 10) {

                            Text("26 September 2025")
                                .font(.headline)
                                .foregroundStyle(.white.opacity(0.8))

                            Text("\(days)")
                                .font(.system(size: 64, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)

                        }
                    }
                    .padding(.horizontal, 24)

                    Spacer()
                }
            }
            .navigationTitle("Us")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView()
}
