//
//  ChunsikW_S.swift
//  ChunsikW_S
//
//  Created by Kngmin Kang on 9/30/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ChunsikEntry {
        ChunsikEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (ChunsikEntry) -> ()) {
        let entry = ChunsikEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [ChunsikEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = ChunsikEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct ChunsikEntry: TimelineEntry {
    let date: Date
}

struct ChunsikW_SEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Image("Chunsik_S")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 165, height: 165, alignment: .center)
        }
    }
}

struct ChunsikW_S: Widget {
    let kind: String = "ChunsikW_S"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                ChunsikW_SEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ChunsikW_SEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    ChunsikW_S()
} timeline: {
    ChunsikEntry(date: .now)
}
