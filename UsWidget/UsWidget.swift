import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), days: 283)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(SimpleEntry(date: Date(), days: 283))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {

        let startDate = Calendar.current.date(from: DateComponents(year: 2025, month: 9, day: 26))!
        let days = Calendar.current.dateComponents([.day], from: startDate, to: Date()).day ?? 0

        let entry = SimpleEntry(date: Date(), days: days)
        let timeline = Timeline(entries: [entry], policy: .never)

        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let days: Int
}

struct UsWidgetEntryView: View {

    var entry: Provider.Entry

    var body: some View {

        ZStack {

            Color.black

            VStack(spacing: 8) {

                Image(systemName: "heart.fill")
                    .foregroundStyle(.white.opacity(0.8))

                Text("\(entry.days)")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(.white)

            }
        }
    }
}

struct UsWidget: Widget {

    let kind: String = "UsWidget"

    var body: some WidgetConfiguration {

        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            UsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Us")
        .description("Days with Arina")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
