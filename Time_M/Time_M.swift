//
//  Time_M.swift
//  Time_M
//
//  Created by Kngmin Kang on 9/30/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct Time_MEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Image("Chunsik_M")
                .padding(.leading, 30)
            
            VStack {
                Text(entry.date.TimeFormat)
                    .font(Font.custom("KCC-Ganpan", size: 90))
                    .padding(.leading, 87)
                    .foregroundColor(Color(red: 255.0/255, green: 216.0/255, blue: 119.0/255))
            }
        }
    }
}

struct Time_M: Widget {
    let kind: String = "Time_M"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                Time_MEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                Time_MEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Time Widget")
        .description("현재 시간을 알려주는 위젯입니다.")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    Time_M()
} timeline: {
    SimpleEntry(date: .now)
}

extension Date {
    // 24시간제 표시
    var TimeFormat: String {
        let formatter=DateFormatter()
        formatter.dateFormat="HH:mm"
        
        return formatter.string(from:self)
    }
}
