import SwiftUI
import SwiftData

struct HomeView: View {

    @Query(sort: \PhotoModel.dateAdded, order: .reverse) private var photos: [PhotoModel]

    @StateObject private var vm = HomeViewModel()

    private let startDate = Calendar.current.date(from: DateComponents(year: 2025, month: 9, day: 26))!

    private var daysCount: Int {
        Calendar.current.dateComponents([.day], from: startDate, to: Date()).day ?? 0
    }

    var body: some View {

        NavigationStack {

            ZStack {

                Color.black.ignoresSafeArea()

                VStack(spacing: 20) {

                    Spacer()

                    // PHOTO
                    if let photo = vm.currentPhoto(photos),
                       let uiImage = UIImage(data: photo.data) {

                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 260, height: 260)
                            .clipShape(RoundedRectangle(cornerRadius: 28))
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    vm.nextPhoto(count: photos.count)
                                }
                            }

                    } else {
                        RoundedRectangle(cornerRadius: 28)
                            .fill(.white.opacity(0.1))
                            .frame(width: 260, height: 260)
                    }

                    // TEXT BLOCK (glass style later)
                    VStack(spacing: 8) {

                        Text("26 September 2025")
                            .foregroundStyle(.white.opacity(0.7))

                        Text("\(daysCount)")
                            .font(.system(size: 64, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)

                    }
                    .padding(.top, 10)

                    Spacer()

                }
            }
            .navigationTitle("Us")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
