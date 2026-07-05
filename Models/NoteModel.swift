import Foundation
import SwiftData

@Model
final class NoteModel {

    var id: UUID
    var text: String
    var date: Date

    init(text: String) {
        self.id = UUID()
        self.text = text
        self.date = Date()
    }
}
