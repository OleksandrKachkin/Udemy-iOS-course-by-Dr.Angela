//
//  ContentView.swift
//  I Am Rich
//
//  Created by Oleksandr Kachkin on 23.03.2022.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
      Color(red: 0.2, green: 0.5, blue: 0.7)
        .edgesIgnoringSafeArea(.all)
      VStack {
        Text("I Am Rich")
          .font(.system(size: 40))
          .fontWeight(.bold)
          .foregroundColor(Color.white)
          .padding()
        Image("diamond")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 200.0, height: 200.0, alignment: .center)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
