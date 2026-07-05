import SwiftUI
import SwiftData

@main
struct UsApp: App {

    @AppStorage("app_theme") private var theme: String = AppTheme.system.rawValue

    var colorScheme: ColorScheme? {
        switch theme {
        case "dark": return .dark
        case "light": return .light
        default: return nil
        }
    }

    var body: some Scene {

        WindowGroup {
            RootTabView()
                .preferredColorScheme(colorScheme)
        }
        .modelContainer(for: [
            PhotoModel.self,
            NoteModel.self
        ])
    }
}
