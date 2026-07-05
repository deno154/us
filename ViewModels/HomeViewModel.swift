import Foundation

@MainActor
final class HomeViewModel {

    var currentIndex: Int = 0

    func currentPhoto(_ photos: [PhotoModel]) -> PhotoModel? {
        guard !photos.isEmpty else { return nil }
        guard currentIndex < photos.count else { return photos.first }
        return photos[currentIndex]
    }

    func nextPhoto(count: Int) {
        guard count > 0 else { return }
        currentIndex = (currentIndex + 1) % count
    }
}
