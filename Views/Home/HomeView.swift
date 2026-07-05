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

                // BACKGROUND IMAGE (blur + scale)
                if let photo = currentPhoto,
                   let uiImage = UIImage(data: photo.data) {

                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .blur(radius: 40)
                        .scaleEffect(1.2)
                        .opacity(0.6)
                        .animation(.easeInOut(duration: 0.6), value: index)

                } else {
                    Color.black.ignoresSafeArea()
                }

                // DARK OVERLAY
                Color.black.opacity(0.35)
                    .ignoresSafeArea()

                VStack(spacing: 20) {

                    Spacer()

                    // MAIN PHOTO CARD
                    if let photo = currentPhoto,
                       let uiImage = UIImage(data: photo.data) {

                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 280, height: 280)
                            .clipShape(RoundedRectangle(cornerRadius: 28))
                            .shadow(color: .black.opacity(0.4), radius: 20)
                            .transition(.opacity.combined(with: .scale))
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
            .onAppear {
                startAutoRotation()
            }
        }
    }

    private func startAutoRotation() {

        guard photos.count > 1 else { return }

        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in

            withAnimation(.easeInOut(duration: 0.6)) {
                index = (index + 1) % photos.count
            }
        }
    }
}

#Preview {
    HomeView()
}
