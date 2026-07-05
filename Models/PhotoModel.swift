import Foundation
import SwiftData

@Model
final class PhotoModel {

    var id: UUID
    var data: Data
    var dateAdded: Date

    init(data: Data) {
        self.id = UUID()
        self.data = data
        self.dateAdded = Date()
    }
}
