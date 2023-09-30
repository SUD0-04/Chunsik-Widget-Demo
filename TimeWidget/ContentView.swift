//
//  ContentView.swift
//  TimeWidget
//
//  Created by Kngmin Kang on 9/30/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Chunsik Widget")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text("For Demo")
                .padding(.bottom, 500)
            Text("본 앱은 Widget Kit 구현을 연습하기 위해 개발되었습니다.\n위젯을 추가하려면 배경화면에서 TimeWidget을 찾아 추가해주세요")
                .font(.system(size: 12))
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
