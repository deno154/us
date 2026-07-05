import SwiftUI
import SwiftData

@main
struct UsApp: App {

    var body: some Scene {

        WindowGroup {
            RootTabView()
        }
        .modelContainer(for: PhotoModel.self)
    }
}
