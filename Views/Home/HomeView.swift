import SwiftUI
import SwiftData

struct HomeView: View {

    @Query(sort: \PhotoModel.dateAdded, order: .reverse) private var photos: [PhotoModel]

    @State private var index: Int = 0

    @State private var effectMode: Int = 0
    // 0 = swipe
    // 1 = auto fade

    private let startDate = Calendar.current.date(from: DateComponents(year: 2025, month: 9, day: 26))!

    private var days: Int {
        Calendar.current.dateComponents([.day], from: startDate, to: Date()).day ?? 0
    }

    var body: some View {

        NavigationStack {

            ZStack {

                // BACKGROUND
                backgroundView

                VStack(spacing: 22) {

                    Spacer()

                    // PHOTO AREA
                    photoView

                    // GLASS BLOCK (FIXED SHAPE)
                    GlassCard {

                        VStack(spacing: 6) {

                            Text("26 September 2025")
                                .font(.headline)
                                .foregroundStyle(.white.opacity(0.75))

                            Text("\(days)")
                                .font(.system(size: 62, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.horizontal, 24)

                    // EFFECT SWITCH
                    effectSwitcher

                    Spacer()
                }
            }
            .navigationTitle("Us")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - BACKGROUND

    private var backgroundView: some View {

        Group {

            if let photo = currentPhoto(),
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
        }
    }

    // MARK: - PHOTO

    private var photoView: some View {

        Group {

            if photos.isEmpty {

                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .fill(.white.opacity(0.05))
                    .frame(width: 280, height: 280)

            } else {

                TabView(selection: $index) {

                    ForEach(Array(photos.enumerated()), id: \.offset) { i, photo in

                        if let uiImage = UIImage(data: photo.data) {

                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 280, height: 280)
                                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                                .tag(i)
                                .scaleEffect(index == i ? 1.0 : 0.94)
                                .animation(.easeInOut(duration: 0.25), value: index)
                        }
                    }
                }
                .frame(height: 300)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .onChange(of: index) { _, _ in
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            }
        }
    }

    // MARK: - EFFECT SWITCH

    private var effectSwitcher: some View {

        HStack(spacing: 10) {

            Button {
                effectMode = 0
            } label: {
                Text("Swipe")
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(effectMode == 0 ? Color.white.opacity(0.2) : Color.clear)
                    .clipShape(Capsule())
            }

            Button {
                effectMode = 1
            } label: {
                Text("Auto")
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(effectMode == 1 ? Color.white.opacity(0.2) : Color.clear)
                    .clipShape(Capsule())
            }
        }
        .foregroundStyle(.white.opacity(0.8))
    }

    // MARK: - LOGIC

    private func currentPhoto() -> PhotoModel? {
        guard !photos.isEmpty else { return nil }
        return photos[index % photos.count]
    }
}
