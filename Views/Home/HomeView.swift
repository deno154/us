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
                        .blur(radius: 55)
                        .opacity(0.65)
                        .animation(.easeInOut(duration: 0.4), value: index)
                } else {
                    Color.black.ignoresSafeArea()
                }

                VStack(spacing: 26) {

                    Spacer()

                    // SWIPE CAROUSEL AREA
                    if !photos.isEmpty {

                        TabView(selection: $index) {

                            ForEach(Array(photos.enumerated()), id: \.offset) { i, photo in

                                if let uiImage = UIImage(data: photo.data) {

                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 280, height: 280)
                                        .clipShape(RoundedRectangle(cornerRadius: 28))
                                        .shadow(color: .black.opacity(0.4), radius: 20)
                                        .tag(i)
                                        .scaleEffect(index == i ? 1.0 : 0.92)
                                        .animation(.easeInOut(duration: 0.3), value: index)
                                }
                            }
                        }
                        .frame(height: 300)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .onChange(of: index) { _, _ in
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        }
                    }

                    // GLASS CARD
                    VStack(spacing: 10) {

                        Text("26 September 2025")
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.8))

                        Text("\(days)")
                            .font(.system(size: 64, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.horizontal, 24)

                    Spacer()
                }
                .padding(.top, 40)
            }
            .navigationTitle("Us")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView()
}
