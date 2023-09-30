//
//  WeekDay_S.swift
//  WeekDay_S
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

struct WeekDay_SEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color(red: 159.0/255, green: 200.0/255, blue: 236.0/255)
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 400, alignment: .center)

            VStack {
                Text(entry.date.WeekdayFormat)
                    .font(Font.custom("KCC-Ganpan", size: 30))
                    .foregroundColor(Color(red: 255.0/255, green: 216.0/255, blue: 119.0/255))
                    .textCase(.uppercase)
                    .padding(.top)
                Text(entry.date.DayFormat)
                    .font(Font.custom("KCC-Ganpan", size: 100))
                    .foregroundColor(Color(red: 255.0/255, green: 216.0/255, blue: 119.0/255))
                    .padding(.top, -50)
            }
        }
    }
}

struct WeekDay_S: Widget {
    let kind: String = "WeekDay_S"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WeekDay_SEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WeekDay_SEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("WeekDay Widget")
        .description("요일을 표시하는 위젯입니다.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    WeekDay_S()
} timeline: {
    SimpleEntry(date: .now)
}

extension Date {
    // WeekDay 표시
    var WeekdayFormat: String {
        self.formatted(.dateTime.weekday())
    }
    // Day 표시
    var DayFormat: String {
        self.formatted(.dateTime.day())
    }
}
